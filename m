Return-Path: <linux-fsdevel+bounces-68080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB27C53A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74C024FBDBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741F346E68;
	Wed, 12 Nov 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMvhAUTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8951F4176;
	Wed, 12 Nov 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963882; cv=fail; b=XdCmoZiFaclTa7LqSgfqaurs24BjmnJyBjQRaDGdMEyR8h0i5N9XgcWN/wxkC8XHt/V3Jo5NzsCdHIIuFjZVJbmL4cDbeKPgCJCSW2o3nDqH2MuG4JElAvd+xsxehzuUxc88/BkGu6P12gp53Ri6K/2F+v1NYBdD43qJgYlh46A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963882; c=relaxed/simple;
	bh=2x7G2m0Uz0LNz3nb1uVJ9Ho6Ozj52mHZ036+3uNWTUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJKeAsE5tvM5i7E4OjQWLZ0Lvki1zJhWlGtRtbN2YBMfffL7v3B9NjJc27u6AaKYc6es+7U6RzfqtkriNVbTHOQ11oAdfTedRXQrnVdudjXYEp1kDBFuVRjZIRjG7zpySGi+cCHIze/PWRK4JeRdxFiCbQ+5TrB2LvlSiRRNwxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMvhAUTq; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfBT/99gscDFriaaxkKpwdmYPlKGfN1xb9oyZT01kNI/m8jscE5e+fQokVPjpNXMXyvCzgfN/imiq37M/cPjYD4w4/tjyPnD7mKsa6vJPgc93xC970NDcim2phSt7cRBm/Nkx7qV4/LtjZD8FdOitr6otzxOA1Dz1z3QoOQCGbq2W1/Yww+cF3/drH4vM2vxV0OOiWgjTpFEmhUJrnES/utT8NA/DthX+euQ/ZAjlqRRHGVlJnZ2PU7nE/1mAP33J160SukaJijABInRsyOewlnY8ncJgJ4jTtnnPxdeZXqVF+hJXC7KNyobWEp8mdbtw8zKiHZ4L4xx+AKoMN39jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3Lxc1rZj8nKGD/MFOCBJGbkR2EsCI4IL4XH2Lxanj4=;
 b=vtszcmf+9I1fkpgR+HZbkd7DMH6+5UxUmUBY2mCMMLxnkFdTGuLcxOJjCFrkfQ+A3hk9IWfCLJZomnW6ORn8XxfAk7qRNgqHzsf0WnMNyfq6YYr86jJMsqVNEJD/rraT/VNRRP1YIIpsRERCw8HK7pJv8vLQ5tuhICCuXwhO2fjI5EpYYeL5IFt+uayUc8RypeOXjLndcinfkDaTo3f/i3pPjsyCjnYSrJ1ChVNaFNzb8fwIlzSRjLagvyNRF1fmgukYGYA3dbT8ixN5odnt4W0TrdoO6a9BQ8mmuAYGHq22GVOhl27Zl4epBDrQiqr5G3LvTkTBGlN17j5oE3b/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Lxc1rZj8nKGD/MFOCBJGbkR2EsCI4IL4XH2Lxanj4=;
 b=cMvhAUTqTlN+mUJW/4gZzSThcgBvCAo+IKVmsU3mnhw7d7RzaUDtHqph4If0P3YVMvm+9dgDi3e5aHYGM4xfoLmktcH1jE4FxT+/0mQbEwUd0kVwAMYwCt6mm7hrsDbgkCthFxQDZgGQFNTX7EkZj3ziMGGtE80b1Ma1dpM+N7cbfVpiHFJP8BZq0bFTek+eeh69tpqEvSCavUDn7fi8cuFAi/+TWZwYjwWvUcQU6CkiZCyvwRAkv4UES5sYZtQzrUaQ8Ujy/qI9WsHIVOOgTMVdtsVwFRrjHfBm397O7qDI+Lg9LQbpnil/b66f7CSzPh6DAoXV/HN4FD1tZ69x6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Wed, 12 Nov 2025 16:11:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:11:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-arch@vger.kernel.org>, <damon@lists.linux.dev>
Subject: Re: [PATCH v3 03/16] mm: avoid unnecessary uses of is_swap_pte()
Date: Wed, 12 Nov 2025 11:11:08 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <CA6617F2-7EA3-4A2A-8EE1-C9CE098ACB60@nvidia.com>
In-Reply-To: <B114F7B2-8EDA-44DC-8458-79E3FF628558@nvidia.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <17fd6d7f46a846517fd455fadd640af47fcd7c55.1762812360.git.lorenzo.stoakes@oracle.com>
 <B114F7B2-8EDA-44DC-8458-79E3FF628558@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 49be0fdc-5ef9-47bc-c34e-08de22061b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcX7qNoEcUyQDyAT5liB19I4ym1eHfmrlGWuJb/d4sfKDrOd9TnGiVOuuGz2?=
 =?us-ascii?Q?HEv7yi6EN56ILf70L3pDhIZEDrr5TLsDrGME6VXy/Z1jsOaq4U6pPeiLJg1C?=
 =?us-ascii?Q?vjqxTtJbPOOxYMkrmQMwf/ivlpm28vrpN278QmL16y64HWRMuVazZ3u5Jb07?=
 =?us-ascii?Q?hol1WDwgo2wBWyjmtFgm3EMRpwapPZXeViVbTBkzonMp5KuB+ngscCckYD72?=
 =?us-ascii?Q?L7Ta3ty0eGH9YRplQQBt9c6/4v9oOwOtP59PjvH/ugXYPRurffrCJarzG77S?=
 =?us-ascii?Q?R08iQrRvXGKY2WItGP17cfkjyv8QcVhJWQ4xZeQGKRZkKEKjl4lQ6ynu6ywO?=
 =?us-ascii?Q?UQrv6Et2I56PiFs7X55gpjOImjjHiMfQoA9mdHfJiiipZyD468LHey/nhHz1?=
 =?us-ascii?Q?h/uRZrvE1sSJVqBO6cJ8UW7HZXRgtJQecmFw5Sa7mpWxVSOjiVBgAeJ7+dtY?=
 =?us-ascii?Q?UYph+nDFjkHQzDU2IkplWp6BUvKdv5gL4SOjG4j3UycvVbHzaNJgaJLul6Sb?=
 =?us-ascii?Q?35SgjD0wDWF2A4g+NFR4KEBuJr5QSGF07rEDc7iPcEJ88vGH5qPbF0956/wa?=
 =?us-ascii?Q?YiBQZka5mcsxxjJeOV4p8KaEcZo+UBahb9zcRYRX9qiFmrQ6VYRk40PrhBLK?=
 =?us-ascii?Q?wo1MgzRXr0h2DGOU8XO/6gri2xPjb+MqPXttT2f6vtaKsNPSb8oD7E6sBprv?=
 =?us-ascii?Q?wacBmfmNrcLLklRczELLlNyd669KugO2rtyzVvc3+OsefpaVQc82EBWDaJqm?=
 =?us-ascii?Q?bJMfwjfHu2w4GasEi9FYobIZjYdsNj5e3nQSVb25yoAd/bARVzGM0oC0e+r6?=
 =?us-ascii?Q?KJvHa/Xa+EYEZFQWVq+e29zq4OtDJxmMPe2K5vfYffroCPtfmIbIa1xyw+4I?=
 =?us-ascii?Q?CvuaFRQ1Z9vpAxHT5Z46ZT3OJLktW5zmr1eChCODgGYv4897Y+xVh8gfNzJX?=
 =?us-ascii?Q?T2dUxq5vAD9/uLYjUkV59F46YLJNnTIObiVtRYQRRGBmg8vFxJM2qdhJVs5Q?=
 =?us-ascii?Q?shdQ46rbildpBmRnIzC3sud8Ri5k/tElhQRPpnhAoaApC59QEVyJv7aEhWt4?=
 =?us-ascii?Q?0EpQpN6F8RYq/LCfeY830kqSPrXZjrmRQFhYMMf4zAbF60TfLGa2EQU7lVgR?=
 =?us-ascii?Q?dqFWzUJrwYX/Ep4WleqBTFwXNJ10iUelH5wkx5kyjRIie/izfo8cNNn01rxA?=
 =?us-ascii?Q?/+QVq6RKn7qoipkOYrsimEk0lQeOzcs0KSzs5YPhwNOvAAtee3E2HUcKRDFj?=
 =?us-ascii?Q?q+OHiEVyZgtuUo3e74VgMaONSmEJZqQ8lui2qGLi/uJblcsVbedgKtVh2NcO?=
 =?us-ascii?Q?yFZAG1ZH5smvhORmfSO6p6gBSsurrQ++TOLqKadbiUl/M8d8a5qhJznkymXN?=
 =?us-ascii?Q?GjEbPJrzFU/lHH4cS3yj4IaFy1kc64ZdkAQus31vewMdM42DwIJruwwciy+a?=
 =?us-ascii?Q?UJlNj1C5YvO7CHObBhPD9sHoSHufewpH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCmGD+u0lB0nsfBrLLlMAAQBLtdt0vTVu129yme7ohl5Avw+MlBE03Yhxf0q?=
 =?us-ascii?Q?381ej7L60VUtPadZYknrP1mbeWWgeafg9dUkhUzCLUyfLbGlDH5aFDak4oDL?=
 =?us-ascii?Q?cOPDwhD9TvFkHvhcvevEgDHwQmBMefpr3Fr3oWlJVynA67uqyNDRSdOcKz4m?=
 =?us-ascii?Q?iVPq4Rn5bLjot5FpI0ZFbh8pl1QEFnOsZYCHJ/bvVmCxjRhvGNZjVid0170m?=
 =?us-ascii?Q?UvBBhrHX9JJboqUdO6Hr4SZNc8WP5Sd9TXeRIN2pary0dUNCPYdDJ4qyDkRG?=
 =?us-ascii?Q?Dsi5Z4YxtIUELRKlNyZQvIwF4WIpLxN5RLUJZ1YQXq2hOmHJ0Vo1QFTHPDDb?=
 =?us-ascii?Q?uGqyk23+GMl2FkATChV0LEjaS08pGO3CxyZm5j7Z71oXqSNlfISGgZMkJSLb?=
 =?us-ascii?Q?9oqvN43aJNAivrQZSzhcGTmBpXtEP/9VLvgWQHvMf0ZYHziHsPf0FS4rTgRk?=
 =?us-ascii?Q?tF06QiUABnGe5N8oSzPwgLZ+nL2nUqxq4crhjmagJFs1faGwgqGMIy9KbzZ2?=
 =?us-ascii?Q?B8Y5LGVonCvuWCXw8bb45/DbxQGAX/mlMWKGWYBbPzk+VOE+J8rtM5juXxSf?=
 =?us-ascii?Q?9m6yPabgUwauXgycFiwW4G4eDYSfx0gaFh4l9xUz78P6PaJoelpHI+GyN2QO?=
 =?us-ascii?Q?fdwSUdrtwfjY0egrgmz3zfJVvAclsWFPsle7dS1eNSM9dMziS5z+zT/SlZsl?=
 =?us-ascii?Q?26+klYKCsKugzFgXVOkmM7vmhwdX81ceB+BzSmT8iBYapMdKu9zUm888ljGf?=
 =?us-ascii?Q?y09ZLBx8fqhyeax0kX1LNQaql+xNHQoA9kiL62IBpdtCXFlEs1b3jrlonOZt?=
 =?us-ascii?Q?BIC4oZS36wvKWhHBKsIQ15zd5Z8VIU/0Jz0co5jm6JpVnwBv3lWpMf8eq1I7?=
 =?us-ascii?Q?z2PeXR8hdyEPx4BLbGhy9oa0fm11gE4GhIvdtCpCh8WOgxT6MMjpDfXvjO92?=
 =?us-ascii?Q?xIcnWLgp/dZCUEb4bYXvnnRDIxvlUgqlR1/pUg1z6j4A+FjOBzcDuBp/RYwV?=
 =?us-ascii?Q?cqr1OO44B6RQv6ZSVJJd3HwYzyZ6sZfxSqUx9fIixrLwidtu+zOJiBphWRha?=
 =?us-ascii?Q?z0xQgD2/yqhClyzOGz/cHVOMSF3DMpvy3eg50OcAhgjlDG1uipZw4SQ4e0zm?=
 =?us-ascii?Q?Doer5azKbMjY86DSvPlMCbgkG/WeRTLlCCXr9YArMzsA4s2NCkChQGrs3/JG?=
 =?us-ascii?Q?4t9+3BT0EfpeNbsqBCZuwJEdAEp4L/PFAsy03UCJyBHPjc4U6DiS+FRGBcMT?=
 =?us-ascii?Q?//+zBhq1klIukApRv8HBx3YOkZe9qKn8MG/ODPx/f++iENoQhMsifX949639?=
 =?us-ascii?Q?kvmPO8yTB9Fx1ehNiJ5ujccEVi0KEr3kDAR0DrUa2b91nyMKDNhVl1svRUdZ?=
 =?us-ascii?Q?MpqGDJAcrCdU/b6pnS5N1ldS7jWfThqmYYa3DwFWwReOT7IDvT/Fwo3zb0Xm?=
 =?us-ascii?Q?U6h57fQb4bYqQZE/855EhkZGRnz2Ebu79UCrF8d/mbynXMGqGT8NjU46JiIU?=
 =?us-ascii?Q?o9uLU7wJ4ufUlgQ23Yp+9Tobd/qjMgZ4kaVOxw89f6JjDGnOTGYL7pAXTpDL?=
 =?us-ascii?Q?YB0+e7CvkW+ZYqSjzuK4VRFp/dW4wiR1jWFwArkT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49be0fdc-5ef9-47bc-c34e-08de22061b15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:11:15.4335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beQ1gPhz5dfNqbQk/Fut70SV2Mb6s8QrKsngHRT6SQwp7ZEDfBvY5wUYBKhS4tdr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624

On 11 Nov 2025, at 21:58, Zi Yan wrote:

> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>
>> There's an established convention in the kernel that we treat PTEs as
>> containing swap entries (and the unfortunately named non-swap swap entries)
>> should they be neither empty (i.e. pte_none() evaluating true) nor present
>> (i.e. pte_present() evaluating true).
>>
>> However, there is some inconsistency in how this is applied, as we also
>> have the is_swap_pte() helper which explicitly performs this check:
>>
>> 	/* check whether a pte points to a swap entry */
>> 	static inline int is_swap_pte(pte_t pte)
>> 	{
>> 		return !pte_none(pte) && !pte_present(pte);
>> 	}
>>
>> As this represents a predicate, and it's logical to assume that in order to
>> establish that a PTE entry can correctly be manipulated as a swap/non-swap
>> entry, this predicate seems as if it must first be checked.
>>
>> But we instead, we far more often utilise the established convention of
>> checking pte_none() / pte_present() before operating on entries as if they
>> were swap/non-swap.
>>
>> This patch works towards correcting this inconsistency by removing all uses
>> of is_swap_pte() where we are already in a position where we perform
>> pte_none()/pte_present() checks anyway or otherwise it is clearly logical
>> to do so.

BTW, I wonder if we could use switch + enum and compiler to prevent future
inconsistencies.

Basically,

enum PTE_State {
	PTE_PRESENT,
	PTE_NONE,
	PTE_SOFTLEAF,
};

enum PTE_State get_pte_state(pte_t pte)
{
	if (pte_present(pte))
		return PTE_PRESENT;
	if (pte_none(pte))
		return PTE_NONE;
	return PTE_SOFTLEAF;
}

in any code handling pte:

switch (get_pte_state(pte)):
	case PTE_PRESENT:
		break;
	case PTE_NONE:
		break;
	case PTE_SOFTLEAF:
		break;
}

And compiler will yell at you if any enum is missing in the switch case.

Just an idea came to my mind when I am reading the commit message.
Feel free to ignore it. :)

Best Regards,
Yan, Zi

