Return-Path: <linux-fsdevel+bounces-50123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EAFAC8633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61453B220D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92816DEB3;
	Fri, 30 May 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPfOnQMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44552323E;
	Fri, 30 May 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748571443; cv=fail; b=Xk8vh6ALbYGOWYa2mlyrpk6kK7BXzFXo1W69T/Z/CjdD8wEf8YjXeBrUuGGlDyFa/Tg6zIEyaTagITvnWzkLgUoZf0pgz9MByUEjDGLyXCw+uwSM6sl+3aByt/LXJa6ev4wVfeHZLjnd+yZTGGPKCHdZTh+BW//4i87NqJlPRPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748571443; c=relaxed/simple;
	bh=7Vf9meRMaTQ9WOSkKaA+/uLYEwyrdjxmhy91g3zIHjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/7C1TWV6bNGMTBdGZ9spGOmA8n1dENUV3lwDNTMhpHrLSQz438EoNF+aw3wbwEKwnezYnGlkv4ie5I5Ghr6Sc1GlcVc4ZkE/RDS5JZUQwJvtyY3LiSqyrbLQIFwAQQAdDWZa5+xKUFDExGOQIUdl9L56qycj5hiJFgmh5Sas3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPfOnQMW; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlJ4M4PMvc2cPnvBu3Pn7I4u0m8hBUOBz8+ir4fhULorkwJLo0iiqJNhSrUCSh9irqcW8dfW8X2cC+PrIiXKBeYdlvnHfU4JxMs8qUYH25F1HFkwkrxS+9SE47VYSlY6yCUZ763NawZ/3Lrr3O25SPVUBu0T7HiuD9Y6U/SbcRkpLH86J7lD1jvna1R0RJHMkdkgVW3TVzA6WT1PzkrsWvg0dXoKOloW1/L4dF6F9mfxjNXpmfzVzGHHDrCl2NjX145eScXuyIjIZY7xYF8SW65Emt6ZhFiei84KF29iSVkaomPetxLDma4XJ1e1zx5VmOVWUj1DwRwF4xjiuQC3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj2LXdwQfJFOD+gRyN7Llk2/oLdX/vxGdQcaot8GZmk=;
 b=gpxZcRuCUd7GMs8Z3IYUvAMmM6PmPnrAajOQEVPo0FPk6Rz2bT5qlHu4rdqrwlUGXVPHMr03Pl+B4mfSmVG+6uz+4m0rSII57KYhFunbPvePSc4ZP7HhIt6Ug6GCqODUU/uEm+17NKS2uj6V1uf7Q8jm99ohFjd13DL1ormUXYy2ipVaUl5TdfWLEA4nc2U6hTRuCKuDBK5RVG6wJV3r+6XjWuS5+YEgAmOqUbZd/PEx850mO4n25SNj7QWC1Eg9Y7n6d68ts8otUAxVJgEKK1Atf91B3lMIrYGwyl6iX2msCgyIECpgtkUv1xlUp285Kf42ibV159CibgQdb+33HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj2LXdwQfJFOD+gRyN7Llk2/oLdX/vxGdQcaot8GZmk=;
 b=EPfOnQMW0JMMTsjLn5A/42yAgudPhbQtLEoF3leJU8Wh0IWPynGBOu5RlMcDigqtad+S/HEn3pNV0wG6fe0P17rF8muUWiNuLx7qhII4toHgHvfmDHNDPZ2U3L8u/L4i5r2mTiCV571vrzkHMVeaIKlegMTh9dU3gOy71ux08PuQ4G81y37YnJdkquFeacn8V7FINfK5YRh1jX32aLbAjsSLYU0D9p4CcIcICeKA9wMt3QO3yBcxZ9nVWZuxs5StOHcIvyx2h5jLfB+LkYti7wSOO0uGGCIDT5ThJLmKh6LCauUhVvBqlvBjeV9+XOMEjU+/XSWvK8P+FkoJ3570Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Fri, 30 May 2025 02:17:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 02:17:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: shmem: disallow hugepages if the system-wide
 shmem THP sysfs settings are disabled
Date: Thu, 29 May 2025 22:17:15 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <D61B9FA2-4EAC-4F0E-AF56-236D37A766BE@nvidia.com>
In-Reply-To: <bd89651e-0ee0-4819-87da-d3a5db04c5b3@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <c1a6fe55f668cfe87ad113faa49120f049ba9cb5.1748506520.git.baolin.wang@linux.alibaba.com>
 <BB3BDA79-3185-4346-9260-BA5E1B9C9949@nvidia.com>
 <bd89651e-0ee0-4819-87da-d3a5db04c5b3@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:207:3c::36) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3799ae4f-aa66-4ad5-060b-08dd9f2019c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFXfd/rpsDqfzEqD427Jg8/VvnBgim89qHB+jU8495waquALx/N3EX8Wt65B?=
 =?us-ascii?Q?I3xDaiAwx2H8wPxxruu8AFVdTueEwka10+SVSb+ZOPbf42I0TwxR1lB16CC8?=
 =?us-ascii?Q?jiqoE6rVDzotWMjP6slSOl8Dj3MnV1mxPKviUdNxX3wAZP31p2aHZ9O4CsDw?=
 =?us-ascii?Q?nmOL2DreCwIUK/8iRybXkd6fFX9KIVrEfMbCUJARXzFrKXkssy159YNYGERS?=
 =?us-ascii?Q?EWTVvbGr8mOR11VdvLZ/1RtYS0dqyzroN6kaSlL+C/jTvAYmoSh1f7CIOP8C?=
 =?us-ascii?Q?hdepxZWNzOcwipzm520Eyk+KSd/0HSwFECeAT80dQEQiJKXN9hPNFYZv4DKv?=
 =?us-ascii?Q?c7tbiQqM8ZOx7yoVnN66fBawyf7egMgbgJwlHadwzJ7uEM1w0u1MXk6ZkmtL?=
 =?us-ascii?Q?a5hLWXeOv06BN7so1hHJ+xdfUpFe85KyGQR6/y8bLtIyGLoxkJVcz4VcNZG7?=
 =?us-ascii?Q?c4Ye6aRhtJei31/+ci1pHguF+jHr3+3/zrGVOhxDvlRanq2YeB6cLj8sUyVD?=
 =?us-ascii?Q?0/D/LcFwIY3r1FoH40Q7FRNgAsI2eY2NQ4q1M4pYhZ9sEgXz9kH/kQxzv/rh?=
 =?us-ascii?Q?hXCPDOOmDfcaF/nyVUXYJsOEuoeeu9vPMhIQT1okyAvxEYtGD72Qol54lHCQ?=
 =?us-ascii?Q?cZWkxz1tksIBrz1WmYE23N2XNqzlmXs46BTDk78qntjIF4NMh5NpLctPMjUD?=
 =?us-ascii?Q?DXZbZZi4sADaH69gl6S4no4AEQ+WqLzG7ywqq9TXM96AjQS6Qkw72hvKK8Jr?=
 =?us-ascii?Q?z5sjJqTHkM9PS4sIVbyErluSSMKyS6960yFWdKM8RbfaNSA/cs+NB7R8yUZz?=
 =?us-ascii?Q?/kgVQJnOOaTw2Q+J6jfIwoa9IIPMsAVAM5G0OhKrrYqWWctREVdqqBURJE63?=
 =?us-ascii?Q?ZS+xCHyJTaLIF6vYvHASED8CL626WJsUQqOhtzDcZJFsPhIrNcxrUwjkcANx?=
 =?us-ascii?Q?vbjx7qu4ZLICqwobfi8TuoEbsCTPP7qmDdXNDz36N/Nvj7KS69/CLEiYpaT4?=
 =?us-ascii?Q?0mAgRz0utFZvxlKyX5hBmEfl6k8eiViTw0QULF3xCnzpQd3bvHFv3o1XmVtI?=
 =?us-ascii?Q?3MvnOq/kLAYPDDfRY5iWHGycj2MA3Nkp7xOUpdlE3LAgZD/Djg5pDLuRQFXS?=
 =?us-ascii?Q?iz5+goHoBWSdD4eRunZOyKDFPQLHYqcSFxDkjTVov6/av30R+3YihD9QTv2o?=
 =?us-ascii?Q?h3fkTgF1UG8kRYUPIDeEuj3VSqBhtcxq3Fk883iOxpaprhrxU5YhZJU3YuWr?=
 =?us-ascii?Q?SK1wINE2zfoC7KgReZeuUyeLjchOcfHGnjf/2TDNjjqyuOsO+aSAhhGeGzHz?=
 =?us-ascii?Q?gLEvg6kF7sQGygrUsqmq9Q406vbm2vo+EIFwiEldvsQMxKUKV+9e5wkuOmGB?=
 =?us-ascii?Q?dthAqiVaT3TcTBDIoKT88Mw86w9i4OhQU9pcV6kElM93FKaRK+lC/j/3xx6O?=
 =?us-ascii?Q?5QQc8D0RYf0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HRItR7M9afd0o+ih1dhIVBCayhnSTkKbb4UXKXaHFwc4Km/FbiTU9gjwauX2?=
 =?us-ascii?Q?k+RLRijfLRa07YXe8I9JNesOjk67xoEV5ycTRg+Yz/kTy7SO2QUworwAPw1M?=
 =?us-ascii?Q?+lSmCeMcACeN2BAXE5ALLfNwqIpPIg5TVl7+U2mc3GN7SXoobV3LYnQF1duB?=
 =?us-ascii?Q?bVjMH+8zTiPmEbgxRJ7OdB3HzMgSXhMlfl0ftkTLmkB3Ubw1AP6r7iZOhnU7?=
 =?us-ascii?Q?oaoPeafER78YhRyaIOTtLva6IFADlIAzg9muxfdkRjPDq8BGAaCYMX9HixV2?=
 =?us-ascii?Q?3ssQF71Jz8qScBk8oG+wkricVSb7sMHTtofTrKzsed6aviWvN7EY6IEZ+sFV?=
 =?us-ascii?Q?lEYw+5Hvq/ffZwGzs4zhKArbWbORzD8YPG0frQd9fze88+qhanicCH4/lQaB?=
 =?us-ascii?Q?g/dbtBTqOX9hIxJ9t8fJ/cdCoRzmwNidtpdxWyL8dj6bSm24t5dZvqCZHxXv?=
 =?us-ascii?Q?8ZWxnJNPfi1fwxlb/SbkVdUWAeoZiYAjkaXd74eHOvWR07uhcCJemAwz6dSZ?=
 =?us-ascii?Q?plASLa7GFTUVt6zHIWXJP5F7TXyoYCnRhst2x/MhX9XhfLs1LfK7Y2r0Yazm?=
 =?us-ascii?Q?aZ8iyCTL1pubZ0qEFYwvdrxgJODshU1RprL5Ya8aJ67OvWqMdTB8otIV6al1?=
 =?us-ascii?Q?zz7t+frhoDgC+mzNHV37AIZrHh/GKwYM7RhaZ2LswR+SpPFFFpdpaKYUaQfI?=
 =?us-ascii?Q?36gYyh+JKSq+NbvuOCN66o/Zb7lYQpw7F5hryGqBGB+PZW7HZ9K7PxW1Q2Gz?=
 =?us-ascii?Q?nxRUqePdfRrW9Jc7NIhsYBhX4V1dEqL5D0NhgxdVM4KcjjLPhA9yT3weWd5Z?=
 =?us-ascii?Q?izzCFk3MIkP8N3fBbC7XOv9LS1c3//auc4cU2NLd1r2Md91gUQDPUXlnkFBd?=
 =?us-ascii?Q?ENMAzKnTgMclthTPnUV85NXOSve76uVYVGA4PG/tbFghKPmbs1dIggznQ+N4?=
 =?us-ascii?Q?RwW3r9Wk4xvnR01nFvee1fUaf1Y/8Raokt59RiejmX20+hRl+ejPZoA/eaO2?=
 =?us-ascii?Q?ehqf9YG5TiduGc4dQmGmXwP/BcWvMDJ5aDfRZsgGDk+2wuFHUDr6ikulUPv/?=
 =?us-ascii?Q?GALaqX208TU9bSr9g7WOJo7eBfJRUJy9m/o83HkTVY7olAAs53A6GY62Cb4o?=
 =?us-ascii?Q?BBUvtC6JQEy30dUj+gKZBuJbye3zrFvhdu36qLCgbu3Jhf9b6leLpWcne1bi?=
 =?us-ascii?Q?ieEbP0u+acwSoGkNauR7mtp2dEF16pPzDvoTd9AUgOhylkB4hunFr6s9UgPG?=
 =?us-ascii?Q?idsYLxon4Zyq1PZkx8ufX92N9INWV3iRfLECbt0Xoecplu0Ke+7ipTifRghh?=
 =?us-ascii?Q?/LCd6cUvMB/KxLVp9Dt7uQu2BaqOf4ChLZsTEhxFL69p1UHX7peOB+Fx7ha0?=
 =?us-ascii?Q?Z5U8sNCO7pkLEzJ33mGcJow8uVZxYyT+Fnxh5nsF/a3lBtGf/KiZEugsv8iM?=
 =?us-ascii?Q?dVRUEWP8FNgOT/ZnJLhaPgG7Hi9trM+RR9PceHqQzUjuESFyWrvlTCgetLgp?=
 =?us-ascii?Q?+95O6uqn9DyEvq8kyvJrWljEMIWKZjw/EXnBGx9FmaJTYyaVnKzaAEa82AFS?=
 =?us-ascii?Q?9cnworrXh+YHFkj9YOr7MSzVXAmoW2LegwpGY0Hv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3799ae4f-aa66-4ad5-060b-08dd9f2019c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:17:17.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut2tGhnCabRsIEyobfdDx0Y1eY4d83P8y7WdNrYmq+ISipGCAhO2jpRvOSnbm+8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

On 29 May 2025, at 21:58, Baolin Wang wrote:

> On 2025/5/29 23:21, Zi Yan wrote:
>> On 29 May 2025, at 4:23, Baolin Wang wrote:
>>
>>> The MADV_COLLAPSE will ignore the system-wide shmem THP sysfs setting=
s, which
>>> means that even though we have disabled the shmem THP configuration, =
MADV_COLLAPSE
>>> will still attempt to collapse into a shmem THP. This violates the ru=
le we have
>>> agreed upon: never means never.
>>>
>>> Then the current strategy is:
>>> For shmem, if none of always, madvise, within_size, and inherit have =
enabled
>>> PMD-sized mTHP, then MADV_COLLAPSE will be prohibited from collapsing=
 PMD-sized mTHP.
>>>
>>> For tmpfs, if the mount option is set with the 'huge=3Dnever' paramet=
er, then
>>> MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/huge_memory.c |  2 +-
>>>   mm/shmem.c       | 12 ++++++------
>>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index d3e66136e41a..a8cfa37cae72 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -166,7 +166,7 @@ unsigned long __thp_vma_allowable_orders(struct v=
m_area_struct *vma,
>>>   	 * own flags.
>>>   	 */
>>>   	if (!in_pf && shmem_file(vma->vm_file))
>>> -		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>> +		return orders & shmem_allowable_huge_orders(file_inode(vma->vm_fil=
e),
>>>   						   vma, vma->vm_pgoff, 0,
>>>   						   !enforce_sysfs);
>>
>> OK, here orders is checked against allowed orders.
>>
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 4b42419ce6b2..4dbb28d85cd9 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -613,7 +613,7 @@ static unsigned int shmem_get_orders_within_size(=
struct inode *inode,
>>>   }
>>>
>>>   static unsigned int shmem_huge_global_enabled(struct inode *inode, =
pgoff_t index,
>>> -					      loff_t write_end, bool shmem_huge_force,
>>> +					      loff_t write_end,
>>>   					      struct vm_area_struct *vma,
>>>   					      unsigned long vm_flags)
>>>   {
>>> @@ -625,7 +625,7 @@ static unsigned int shmem_huge_global_enabled(str=
uct inode *inode, pgoff_t index
>>>   		return 0;
>>>   	if (shmem_huge =3D=3D SHMEM_HUGE_DENY)
>>>   		return 0;
>>> -	if (shmem_huge_force || shmem_huge =3D=3D SHMEM_HUGE_FORCE)
>>> +	if (shmem_huge =3D=3D SHMEM_HUGE_FORCE)
>>>   		return maybe_pmd_order;
>>
>> shmem_huge is set by sysfs?
>
> Yes, through the '/sys/kernel/mm/transparent_hugepage/shmem_enabled' in=
terface.
>
>>>   	/*
>>> @@ -860,7 +860,7 @@ static unsigned long shmem_unused_huge_shrink(str=
uct shmem_sb_info *sbinfo,
>>>   }
>>>
>>>   static unsigned int shmem_huge_global_enabled(struct inode *inode, =
pgoff_t index,
>>> -					      loff_t write_end, bool shmem_huge_force,
>>> +					      loff_t write_end,
>>>   					      struct vm_area_struct *vma,
>>>   					      unsigned long vm_flags)
>>>   {
>>> @@ -1261,7 +1261,7 @@ static int shmem_getattr(struct mnt_idmap *idma=
p,
>>>   			STATX_ATTR_NODUMP);
>>>   	generic_fillattr(idmap, request_mask, inode, stat);
>>>
>>> -	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>>> +	if (shmem_huge_global_enabled(inode, 0, 0, NULL, 0))
>>>   		stat->blksize =3D HPAGE_PMD_SIZE;
>>>
>>>   	if (request_mask & STATX_BTIME) {
>>> @@ -1768,7 +1768,7 @@ unsigned long shmem_allowable_huge_orders(struc=
t inode *inode,
>>>   		return 0;
>>>
>>>   	global_orders =3D shmem_huge_global_enabled(inode, index, write_en=
d,
>>> -						  shmem_huge_force, vma, vm_flags);
>>> +						  vma, vm_flags);
>>>   	/* Tmpfs huge pages allocation */
>>>   	if (!vma || !vma_is_anon_shmem(vma))
>>>   		return global_orders;
>>> @@ -1790,7 +1790,7 @@ unsigned long shmem_allowable_huge_orders(struc=
t inode *inode,
>>>   	/* Allow mTHP that will be fully within i_size. */
>>>   	mask |=3D shmem_get_orders_within_size(inode, within_size_orders, =
index, 0);
>>>
>>> -	if (vm_flags & VM_HUGEPAGE)
>>> +	if (shmem_huge_force || (vm_flags & VM_HUGEPAGE))
>>>   		mask |=3D READ_ONCE(huge_shmem_orders_madvise);
>>>
>>>   	if (global_orders > 0)
>>> -- =

>>> 2.43.5
>>
>> shmem_huge_force comes from !enforce_sysfs in __thp_vma_allowable_orde=
rs().
>> Do you know when sysfs is not enforced and why?
>
> IIUC, shmem_huge_force will only be set during MADV_COLLAPSE. Originall=
y, MADV_COLLAPSE was intended to ignore the system-wide THP sysfs setting=
s. However, if all system-wide shmem THP settings are disabled, we should=
 not allow MADV_COLLAPSE to collapse a THP. This is the issue this patchs=
et aims to fix. Thanks for the review.

Got it. If we want to enforce sysfs, why not just get rid of TVA_ENFORCE_=
SYSFS
and make everyone follow sysfs?

Best Regards,
Yan, Zi

