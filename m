Return-Path: <linux-fsdevel+bounces-50077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D545AC8030
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B517A4268D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9722FDEC;
	Thu, 29 May 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISHAS8ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3E22F166;
	Thu, 29 May 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532084; cv=fail; b=KOFoPVEJUYqL/XMF8X0qcZVPhcTiG2f089E/XXiXJxD4rjLRnBWWR8RGFBYWRg5ybb0UFHNFL8xxztzG9EwevOhuTx/49ELQlmGU3cEhttxYjD6hFj9CJtdaNcGUknwO8IsQXAHzb1T7KmajNrrzh2Nrb5BVrBWaOaZ0Ye4vq78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532084; c=relaxed/simple;
	bh=XOPoy6uSINJDinQN+G2/ZvLBKVURlov6KYEpijA8YKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAWb9/IqDRsiLJD8PQyP7G4gE+JwkMQAAGEF3Q4vdhfUyvr2llTq8qSyJUy/FqU2MU6xC4xo7NG8tP3MnGxmadtEml48BT1TbhVrXx6INvtLNPdnY8UNFlQ3LK88xtKCBXByQqWft/Qh7qqbS1GRktEy+UKxEfvsrddeJkJpEWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISHAS8ql; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNaulOfIvHZdL4SzhQR5dYpU3SbpBjzSWUTN1YwsZwVH2yVKZUv2w2f4KeGOP+EdsfLUIeFU3tZkP1mycXGYr8fP44nt4WnYBfCzjhyfwtd2L3JTw9QpSyxiT0sD0p4oxDqfgrJoj/1jJyT0ThHSvmHJUfVqF0llYpFBlZSa0mzuj+KjKjUeln5t/ggiBdjWtym8Aul+x/GHRWog7Y2IeHqeBN3hQpB3ociphdt44Cb2eNegw2DrCUHUuSf4BpDi6RuBD92srKvE8+v/l1BMlyxWFBq1cPxBSSWiGIpTlwkJl8r0SmaMGnEsGSMnQggX6eHzpOVGDJk29z4xSO3PUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60XXxnMSBwGcDdqtwi6bw5PE7YThq00CBn3ifuNBtiM=;
 b=aDsoASM1n3rwT3g/79NQn9qojAtfkj6T8ylZW6Hvu/OxGfCY4QUdhNE6JAlRBuYM4qPjbE94oLe8+wWkIqbPl8L5MqUhnOxYmTPnJWbuTyZVav25i5YaRCFNEOm/vFssBFFHNhMIt8A829kEeFJmX8STW0CkbD5Aq3/8HfLxBb4+0ho+4FAk+QAinIqHNoXp6i0FlLQi/+eMLYdhkL6OicpGYWquR3E1S90Erbq7uijq6a3q+e8b/rxVqQDudjHpiGCGp4TtIjkoYxbsnvIrL9wqSRxsROgQwBfj9wDhNOfQ4Wq9CkKOYmNG1tgpwGLzK8rP2h/EQDaVFMihl4Fu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60XXxnMSBwGcDdqtwi6bw5PE7YThq00CBn3ifuNBtiM=;
 b=ISHAS8qlF+DnsMYmCdivSlh9n3m8ksZUTqjkvk2CXrO2lyVI0zZ3e1RAeqMjTy6cFmsCsToc/CNLA+8uBzEkR5UnyAnml/e3d8ABi4VwxoJkaOYcQTzxi+0sb/6tP0y10MSev/CvTBG1zxfD/erjcDHHDI84mrbEVeS/p2HLYaEXkoIqOHg4gA1CsyOXEirg8SEmOgNSbK+UpYdZAwlip+q2+moUGZNc9S0A0Wd8UjGirJb0+6Vhs6q0dhYULqC62aCKOOavs2C+hGBvHZ/joNgkqMITOurgtQLd1iE0g9+asXkkjKT4REcfCUNIk0VFkNCwa3D3FB/EKOSHfitaNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 15:21:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 15:21:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: shmem: disallow hugepages if the system-wide
 shmem THP sysfs settings are disabled
Date: Thu, 29 May 2025 11:21:11 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <BB3BDA79-3185-4346-9260-BA5E1B9C9949@nvidia.com>
In-Reply-To: <c1a6fe55f668cfe87ad113faa49120f049ba9cb5.1748506520.git.baolin.wang@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <c1a6fe55f668cfe87ad113faa49120f049ba9cb5.1748506520.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 786cb66d-b822-4b6b-6107-08dd9ec472a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oyc5sZZLwhW62JKTerGnHUpvhYdW8J0+e2G0tHx9jEau4G8MTK3QaHx5bZAW?=
 =?us-ascii?Q?aVEUnrkOjg8wgeSCOhkShu6oOlKLC8I/brcKFEGAL5CdFNX9zEXdUweWf5E+?=
 =?us-ascii?Q?BWmTvmUJXy+tO4Z9kl9ObqM7E2YNwSOtQDeryhyPvG3xEZCFV7ze67huVLrq?=
 =?us-ascii?Q?a2AqCzlcSAWkMlN7M4l4di4zYL6/KDE60SWZuGLSh9LWhfET74UnsdQ+bgDN?=
 =?us-ascii?Q?I6afx/7ciwHl6ne+CL2EJLh39FmEXdYeZlwagQuCl20A7UjCFoVz7IynKnzs?=
 =?us-ascii?Q?H98F3yh9B5PymYuBmV5tmxa8S8+eQJPkWxh03Y8B2961I3Zc2liw5nsoCr1A?=
 =?us-ascii?Q?i/dV6Re/8dB/x/+PyVWC7IyvJXWdxnlbkM6bpmDVi4V/l10ARfcdLnIBl19w?=
 =?us-ascii?Q?XaJlUgsKPhWGxzq/1CUmWsW1ceH07a4LNIZHvn4k7xMeom0umZTn8WE6qg73?=
 =?us-ascii?Q?lLhvvQhQix5tH76rVcuZTHoCQKIpCXO9YRpii2nWL0ehpxir0uIqB4HZtynP?=
 =?us-ascii?Q?6D699cMMqZ6MDfSQ1aLNYVNtXM5K8dcm3MYtlRJAY0mc7Cn59d1KABwq5i2c?=
 =?us-ascii?Q?Qd0ZN99ibqtAOt8LL1jm05ma6ElnAtTISeAQfJ1meVNpw4mC3insx4nscqpC?=
 =?us-ascii?Q?vUhQXz7x9YSxN6MzZ5770kD0gVndqymko6XWV03Jdw4dB9cQTqeodH7XOaoJ?=
 =?us-ascii?Q?Wz3WOqPIYgPiyPdlQmCws8n9H30vYZk5kBO/xoM2WK9KfJvHE2M6ccC3D0ON?=
 =?us-ascii?Q?RJJZxh20GFFdwodbp66LAFaYq6QPiZ0hbOlnmtD9UkxAsDIADFhhNRFu7Bpm?=
 =?us-ascii?Q?TuTeTIJyuKMejG88sChzQAW+LAa/LVPygHq7rzsRc5b0PRDStyEEKgw3J+CQ?=
 =?us-ascii?Q?xuxRq6a/1uCNr7jp0MXQado5xgENM5ewBPfGVQhIedGSoOaIrlqz/zVd30u6?=
 =?us-ascii?Q?fg1R6L8lOmCqf00N4H7vKD8rrr4I4Euqyuw8V8xIfFcS3TyHrKJKnP6SJg31?=
 =?us-ascii?Q?JKVLyIMRWzHsmifhj0QSNT2DUkFJbFvWU1NqHl1Uqp7tbFoGxl+naKlp2h3Y?=
 =?us-ascii?Q?/FHAjflfoBPIhtF9noPcBecpvbFDoBWvhcH9ZGfeS4LHUDAmBTHAbLpbYb4G?=
 =?us-ascii?Q?lG5ZOVtFCkKkF7pxh/0sPfgijjyr0YzI7ktPUvca7vNAco2ooVsetjhH4Er4?=
 =?us-ascii?Q?BeTx7H/9tn4/dqZoXtmbCg/ClEuUDx4AsjFR/ulfsLjAS1Y4OYZq773nz6DC?=
 =?us-ascii?Q?G3rMb1oUDbBtao1XKdfvtYM3scR2fKb3dDYV5BN7C7tPHf3L0M1tsKdc2r+X?=
 =?us-ascii?Q?NAa4HohZJlKA+VDaJ/NyEAudcu9XmBb67oKogETVM6BeKTiYDtBhyJwCmExR?=
 =?us-ascii?Q?U/lSSZ5pOa07OoSocfJaYD8yFyxzXMGMoqUhaQmzI29gZVhWSZpwsoZ+06sZ?=
 =?us-ascii?Q?HaEsC33RtHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idcHfEeV5Zcl+8OCKKAJt0hBreMES5vaDC19Fps//zIn+24oJuGkr+InYqJZ?=
 =?us-ascii?Q?G1hGL/BxZinfr6XiFACb0GMGqsWo2oH4MvV8iWh2IQcXiw80TndeeZe7Mzi5?=
 =?us-ascii?Q?OCpO7GWHEvB7mKmTeeCzrtLxygX2ewJCPrMrsNBYK7VHBgS0J/gsMkAqRWVh?=
 =?us-ascii?Q?RVmrInC/paUBGRNsaoqk2NW4kIFW60a1pHXZmvDArJ7fWHLpQdrWGDfImrZX?=
 =?us-ascii?Q?zD242ARaGRSAHEu9HEsoK5sURzo5bogY+fNBmvrUo9a4Rxl6eGkJG7AHE9wd?=
 =?us-ascii?Q?fw9dCYyocuYSDApt19j+oJ+pCOCIwvIvNW0k6KUHnLkr5hKXHghj+EmYw5Tn?=
 =?us-ascii?Q?Mi/I60eoNHZk5dvf+vsu48fWpKQiKMqeTfhMiUUtGxruNUNa3aWS/eBz7c6U?=
 =?us-ascii?Q?9TxIXLNpriTpr2GAKNrsv45CxKeXACyVRMNm82tBhFCBjQFKB5nedd1ZbUaE?=
 =?us-ascii?Q?xDyZ0I2g8j4sWE8ljVV269GMEA9wbA0yA7d5ug+ECfFHLnuulHPDn8rLxq2O?=
 =?us-ascii?Q?zpaLiOWO42ocmmx9H7BLXTDPKrdCuPBITmko439ZAzQQ/ZeVkJFf+0c18rhB?=
 =?us-ascii?Q?9GufysXtmj/DcBA9VnK8oB2th3/6CYtcyb6RmWkvZNrcKzN11TckYcLmK2uE?=
 =?us-ascii?Q?++ZJ2A/AXiKCR7J81kKlwYGPUA/uV18Cf9YYGHcncHgEIzDfINwwm0Dy/54i?=
 =?us-ascii?Q?bU2fvvjKgP5adsjHacf3DygmlLKq8qtLzbajcsUBQp73adXYwROH0C+d4ap3?=
 =?us-ascii?Q?pgyCfcuS5EMS8Od5UMSpWnrM8KpS9SrojCV2gAmxUZMkMnlMywOPW+xobcp5?=
 =?us-ascii?Q?+Y2T5SXGF5vvS/PYIAyKnyF57RvffmFnj9vn/aiwEP0ckunOZDVDcCnVnBcI?=
 =?us-ascii?Q?oTOGw1vaZQbvubitze5ygz6nqppQsuvCkuBMZXHtcUq1v8SjK74752FwToy6?=
 =?us-ascii?Q?V/fhQ35u+hOe/oJeQMQCWGi4XcIoy992+Vsuhemb0GYE1ui0gUYYff2WgJI0?=
 =?us-ascii?Q?hweDaFoXb/B+xkSlhD7U7XLLdL3Tr8+1/EIa2gVpHk/rX9coJ+h7n3GEGAdu?=
 =?us-ascii?Q?HSUoqiri4YV+jywJYdG1FWBa2BmT9MDkMtmlMIfSvrJyc/8cQ4jeZhdNs0ve?=
 =?us-ascii?Q?YBZcQMOxJ5Vlj6IhX6GpaB45xEbesoeURra38SDOQKCKFvsUXvh6/LTV3Emi?=
 =?us-ascii?Q?n1uoq3OtXJIzWcAc1vriDjnUdKD8thxrr1sjEuutVAi8+PRxw9YJ8aiQdq7q?=
 =?us-ascii?Q?DPISc98tB0n10JDi1B6TslKjbtCG3Lbp4ObhmSA/m17SeLcxQJi29//Doo/P?=
 =?us-ascii?Q?Ow4PgtBG/H+mvtiCWrQ7A81JL3lA79C0ssXkdc1s0Wz0B1AemVG30z1btcxc?=
 =?us-ascii?Q?WQG+4a8PjcIEsSbFM1tyjLIL3u07fnqyIlgUDUbkMP3t/mvBf2tPuhrwhGnE?=
 =?us-ascii?Q?2d7zR44XjAZngO1ytbZycm9K3ZmvARnUV96w/TDdSgYUiURvT3VXQ/lVMeFL?=
 =?us-ascii?Q?BSrNXvZGqKw1kcODE6dgUtIemfrwJAQ8Ot6Vl3p/nt3+EYgBu2C/lU2GUuoq?=
 =?us-ascii?Q?+5jQV000mR/CuaRUy6hPGHqmhZtPaorkdeNPFnJP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786cb66d-b822-4b6b-6107-08dd9ec472a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:21:13.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bESJ+tbjLIZmavcr9mODknolWqwYMgGT8pNBwjHkecAMT7xUxMjnBlYvHUb220Su
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

On 29 May 2025, at 4:23, Baolin Wang wrote:

> The MADV_COLLAPSE will ignore the system-wide shmem THP sysfs settings,=
 which
> means that even though we have disabled the shmem THP configuration, MA=
DV_COLLAPSE
> will still attempt to collapse into a shmem THP. This violates the rule=
 we have
> agreed upon: never means never.
>
> Then the current strategy is:
> For shmem, if none of always, madvise, within_size, and inherit have en=
abled
> PMD-sized mTHP, then MADV_COLLAPSE will be prohibited from collapsing P=
MD-sized mTHP.
>
> For tmpfs, if the mount option is set with the 'huge=3Dnever' parameter=
, then
> MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/huge_memory.c |  2 +-
>  mm/shmem.c       | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3e66136e41a..a8cfa37cae72 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -166,7 +166,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>  	 * own flags.
>  	 */
>  	if (!in_pf && shmem_file(vma->vm_file))
> -		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +		return orders & shmem_allowable_huge_orders(file_inode(vma->vm_file)=
,
>  						   vma, vma->vm_pgoff, 0,
>  						   !enforce_sysfs);

OK, here orders is checked against allowed orders.

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4b42419ce6b2..4dbb28d85cd9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -613,7 +613,7 @@ static unsigned int shmem_get_orders_within_size(st=
ruct inode *inode,
>  }
>
>  static unsigned int shmem_huge_global_enabled(struct inode *inode, pgo=
ff_t index,
> -					      loff_t write_end, bool shmem_huge_force,
> +					      loff_t write_end,
>  					      struct vm_area_struct *vma,
>  					      unsigned long vm_flags)
>  {
> @@ -625,7 +625,7 @@ static unsigned int shmem_huge_global_enabled(struc=
t inode *inode, pgoff_t index
>  		return 0;
>  	if (shmem_huge =3D=3D SHMEM_HUGE_DENY)
>  		return 0;
> -	if (shmem_huge_force || shmem_huge =3D=3D SHMEM_HUGE_FORCE)
> +	if (shmem_huge =3D=3D SHMEM_HUGE_FORCE)
>  		return maybe_pmd_order;

shmem_huge is set by sysfs?

>
>  	/*
> @@ -860,7 +860,7 @@ static unsigned long shmem_unused_huge_shrink(struc=
t shmem_sb_info *sbinfo,
>  }
>
>  static unsigned int shmem_huge_global_enabled(struct inode *inode, pgo=
ff_t index,
> -					      loff_t write_end, bool shmem_huge_force,
> +					      loff_t write_end,
>  					      struct vm_area_struct *vma,
>  					      unsigned long vm_flags)
>  {
> @@ -1261,7 +1261,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,=

>  			STATX_ATTR_NODUMP);
>  	generic_fillattr(idmap, request_mask, inode, stat);
>
> -	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
> +	if (shmem_huge_global_enabled(inode, 0, 0, NULL, 0))
>  		stat->blksize =3D HPAGE_PMD_SIZE;
>
>  	if (request_mask & STATX_BTIME) {
> @@ -1768,7 +1768,7 @@ unsigned long shmem_allowable_huge_orders(struct =
inode *inode,
>  		return 0;
>
>  	global_orders =3D shmem_huge_global_enabled(inode, index, write_end,
> -						  shmem_huge_force, vma, vm_flags);
> +						  vma, vm_flags);
>  	/* Tmpfs huge pages allocation */
>  	if (!vma || !vma_is_anon_shmem(vma))
>  		return global_orders;
> @@ -1790,7 +1790,7 @@ unsigned long shmem_allowable_huge_orders(struct =
inode *inode,
>  	/* Allow mTHP that will be fully within i_size. */
>  	mask |=3D shmem_get_orders_within_size(inode, within_size_orders, ind=
ex, 0);
>
> -	if (vm_flags & VM_HUGEPAGE)
> +	if (shmem_huge_force || (vm_flags & VM_HUGEPAGE))
>  		mask |=3D READ_ONCE(huge_shmem_orders_madvise);
>
>  	if (global_orders > 0)
> -- =

> 2.43.5

shmem_huge_force comes from !enforce_sysfs in __thp_vma_allowable_orders(=
).
Do you know when sysfs is not enforced and why?

Best Regards,
Yan, Zi

