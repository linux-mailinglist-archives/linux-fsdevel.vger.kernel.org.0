Return-Path: <linux-fsdevel+bounces-35518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9699D5767
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8E0B22E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC5188583;
	Fri, 22 Nov 2024 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SaC8VsqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B5186E34;
	Fri, 22 Nov 2024 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239715; cv=fail; b=CIzMA7RsMR1skJQMI5SLMWKUXw7U5JDW+6DHEGuqj+gSfwWJhmA+hssv9odq3gs/t0Dnm4kdgzPazRNs5p30GAf+K+tu/IcpFul/mS6k9N0Ryt07atwcZzaseheZZc8/jfm7WOSoWelAOhQmzVoj2IOCargfO1DDM1KMme9KUWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239715; c=relaxed/simple;
	bh=UxMjaFoX1XecxjsEqzxRhn/ytYG90McKoDDNSu+KFPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B28M9bSLdkuNKbXHIXCJ0XfTp+/E8VSfxinLxPh8GjYhtRI6EivxBgluRqDWAcC7DsFqCMAZeamyeYa+wPUpkmPgXV01EMM4BVOf1zH2UHk3H/pPQqBugw0RgM9oAqsqXvRDkMXs96VBYABFbPLaHPE3SKT7OsmxCMb/j0WymhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SaC8VsqI; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q74vPdUt07D1cdNw7Ya/LRPqiC8rZXjBnxu5S7qU9y7UPB8n975ZJRCIr6NfHHJQvn/crImYfSTzYEWlOgp/1u2KxGGOkrjk4PCic5MNmFKuuABhCGVRC7UMrZuBbRxI+XWZ7KYyJYnXIHTcgHuIyGvgoPFdYhDUzynqIpeejyXVJM4hHFR6LllkZWty/rkF/nkh1/kOGKANFQnx5bRICUf4Ythf10q9gUWa1NHCFuALASMZqgAEAR6mCQsR+o7cBcf3P60Rz2TpIJlJkgqimm67qvEQtbMfrofqgg5XfEDOZK0NUFwJFmrcVnDAil8F4NAnhWyeHu+Q4sIE8TRKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+Odtnntc8K4ZZvVtUiGn9anzLC7nGpzGIZ4FsGVPrs=;
 b=vd1xH+pmY8U/EYlfw+CF8oE90a8vo+Mswi9Uk7KIgSngStnnaN3qrlgzbhE9yEgz2EoPkr7q4j/IJCTp2Lfb1jCKBfeOMByligGIk1ohXAJySSuLbywAjcgCSvu8ty7jJJssxv+v+8JtRjwh6G+pO32OQ4IVu5kr8OnDcXvw8X92NN4Vfd3WpOTRO/ajfcUZJ4twraML9Gbjge3+FV6P7BMiVxbcfuXl6Y7DpbnowPGXqRhC4BTViznnQ1NI5mj0U/GK8CI1/mD6jv66GqxkH20MKS6fspNQ/SYcW2ZuH0a5N3BbXQCMHTW7hqTAU21Sn1Y/szwTQbtq17Tg1VAlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+Odtnntc8K4ZZvVtUiGn9anzLC7nGpzGIZ4FsGVPrs=;
 b=SaC8VsqI4GK9Rz37vqiEMEqVpT5mWsM2CHMeaiGveJo4ciKA1pT79ccCrKkhYR4O6UKnYOuBNZN0dcDMVIjGGhRv7EdFjX7RctUlH2IURjGwMrMuSTBtgEU19Nnbs3LwuHOvz6LAdgywGywJdp+MLoly200I72oyxSQX9uvzE9f/43+7i5p0lr3//eZNxWrkIgYQebIWZDuqnJewFouqTT8B4xhaRlct86+d4MTKZievfeMEe+26vcUoioGou+e+d400/ItAstQ6ylz62K5RRTuFTi5m2SD07IKvIU7nl/svWaTfzJjkkegix1vm5a0DJhu7IBQB0vBoIeLPl7pk8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:50 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:50 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 09/25] mm/gup.c: Remove redundant check for PCI P2PDMA page
Date: Fri, 22 Nov 2024 12:40:30 +1100
Message-ID: <d65a5c7091e36d6b402ba0d6b36a353bf17d75ea.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b094f9d-e52a-475f-479b-08dd0a96d5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvA6NCRRYiVzdu6A3dLyR9pI/Qm0Gcp6VuJKvryvuqy0TN0+lAZZqs1BRE5R?=
 =?us-ascii?Q?c4y+sHxiB9jGA0lLWBueA/4hJXX9ohcy70Qe5MVK5eUDaTJupumNpL4pyPCE?=
 =?us-ascii?Q?0lLU+s9VDOqs/jlo9GH3lrQXKBGsGQmDZm0KV24Sx6jbaAHdX0mVgimsPpO5?=
 =?us-ascii?Q?esBYGbJSdsOus9QjSGUPPPJHnZpMejrgJXOzJmqasqqWSLfANhdVPwURPZpE?=
 =?us-ascii?Q?qmaJE5zljaAPuG/6POOSMz1YgfDghVyhuhmsinLPV8XiiJcDpFzzqVLp8oYP?=
 =?us-ascii?Q?3wNxnxut03RCL04d/zb2uMpjf8o+P+lRg0knrs+ifW/PuiuA39Qz5wN9yrjq?=
 =?us-ascii?Q?CC1PTjY8B8i0npNAUS5wCTC4AAX7hO1SlDZYPQtt3+G1O/4JoYeRSR4vaQFe?=
 =?us-ascii?Q?gCnhHVacbAfbsymQxOQvKU3dZ9V0P6lsCHlQdoym3HiZMHt7FaiedrUIb70x?=
 =?us-ascii?Q?wWz7wWw/zdyzSmC60xsa6tL1DnJ6dalob2fG+pSuZBvrArrXvBsmmc3UPFU7?=
 =?us-ascii?Q?QnQYyxS8J+znhbrLwOgT4qSUTbuE639MMplMjGABU8jkmXNfuJQRzfXLjKlb?=
 =?us-ascii?Q?vYHrkd19eCQ/ifUPFNwMqJUM1Ez6wJEuieJBaJi389/5GsS8aE5+d6T7HdYK?=
 =?us-ascii?Q?5STWPgj9mewTg9W0suDMIHvd+Ug2HvddvTRDjuksiOt+u2nyhWLvzAeaFoy5?=
 =?us-ascii?Q?H0XlB/Ta53Tt6+kjv1p1wT1yD9j6S72r6HmTmEpq03m42xYpSo0t6BXwxSPp?=
 =?us-ascii?Q?6QAS1Ri1oASyr7jpCeVNY+QJzZvqVrzSr72Y4VJNu5jhtjMfB37xkW44o6rB?=
 =?us-ascii?Q?ObmVDnijfx7J+NBm4ddlU9hLyEl2JO74VQNG2wUS0OhpcjS6/4QvWSxCSRmn?=
 =?us-ascii?Q?q2Tjt0ipZLwAM8JOEbK7to5RfMKA85G5pANg/eqTr51K47YxSr/cEpXwBNFj?=
 =?us-ascii?Q?8HxfkHgL/quESgSliK2502lBNu12FEMpD5GzvyKVufBnNC82n3XyAMsW7eYU?=
 =?us-ascii?Q?IsjNerWX4w7ZYZ6xMNvltvlSF5KaTYv1ux6B/Sr/upn6w3opRNDQYajVMiP7?=
 =?us-ascii?Q?sAbnO50sgyWh1vCsemym2gZcZ2OpXOp4zaR/BUYg7dG6PzyXsyhLPWBe/B4c?=
 =?us-ascii?Q?YRZJfoKxJUK523sDNETpZWG8lBycui7zeB9WDbsT/N1xrFndL7jVl9+lFAwU?=
 =?us-ascii?Q?ydxgPuqR5Yp4OVIL9zH8APsA06mgSPNWiawmRuZiGZ4qkr2b5lrsppNfocAp?=
 =?us-ascii?Q?cn1jWNpH6/wZsHWdYnkx6agVJnKSQglw2miNrqi65dQPTMbZ4k9jAN8ngPbP?=
 =?us-ascii?Q?Z3PZgyJSwX7uEEi/FK1mosX+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UE6LSHOB7M+4wt9f9x2EUfiUNnfbOXCrmm+PRQ8BYLS1TRHeD28KoER4Mhpv?=
 =?us-ascii?Q?xZ0bobXSiUJHQdeldOADQhyUuTb4+FHzcmGYbjSxj7HaKAit+6O3VgUDnl7H?=
 =?us-ascii?Q?rFfSx+F/Dh8fYd2mlZ5EQWYxSdCAV093aCbZUfbtSFqwKmlL+msWVT3aP9io?=
 =?us-ascii?Q?eYqXglCkujWC2bKZHCadyIwUULXQI8WHW/RKY8BwTUSafpA4JGxvUR4qJ7d3?=
 =?us-ascii?Q?hu07Wt0KI7EeByUNeAwYIqYQC2Fh7IXzg1CShrGheyniLZ8CWUCJOEUaSTa8?=
 =?us-ascii?Q?llFTCh7nY4SCdx9AaiFW0njjcdqbjsN4Y4eWKaGi88Gx2WvGnjzRQyQstJ3Z?=
 =?us-ascii?Q?Pts94K7m7KL1CGJFequQqd45k8edwOXKwiS00wHVhilwVoSBk74/DDBQtovC?=
 =?us-ascii?Q?OhdHNQfJ7rbyKByTliK2OCXSsfK+P5ItXIJBLUq3fyqp8j1UHThta6JkDu9q?=
 =?us-ascii?Q?L5CaSU3ZpNEUZvHVDaH/zD2esgybFjfbxAJTLUHLaVVqrBFl0nSg6848OBDL?=
 =?us-ascii?Q?woUyZ7NWoKcK/ELOF1RX06RVT3f7f8ecI3n/IOdjDUXAlZrye18Z5m7nMErX?=
 =?us-ascii?Q?B/HkulrNzKIuM5PNB3Qfldidynv1O/OEp+goC+NMT8anMho5JfNXlokvid9U?=
 =?us-ascii?Q?h6c9XszWEdY2aVgcKipdherISVZzC+WPFvj6pzdynkRW1npcfJq6MTrk2e20?=
 =?us-ascii?Q?QJo7UrIB6plE27R0Z1MgcBaTlCbjELh8r/nV8ldvfzdWupVeTVvU9kzITAxC?=
 =?us-ascii?Q?kcruAIelkDNvBtKCb9CguiW96fQ+9BqEJE8SLrqjWNfkZJUKkpeE0q1xfZqv?=
 =?us-ascii?Q?KK7qM4VxK+pqYoRNqyWbUnCJtt1vpimYuKuVGWIVZYQAfoQxuIZGzMONsXVO?=
 =?us-ascii?Q?1DKKr73KnTQRabDiVnzNC4yjHlEP9OZ+ETSw3/zGeUGM2ZmJSwBoN/pJvw/Y?=
 =?us-ascii?Q?XUEEyjRhuTZNzRpFx0t1IGcXFafokE5AFWTWpqc22ws3MBeqNN/SQOs1d8ia?=
 =?us-ascii?Q?PiCgtGwAjou2xHgCKJzERbfOEL9n2AToH3QScu/FnK0DNJSHR8y6AUu80h5J?=
 =?us-ascii?Q?/nZ9BwQ3qcXPDgGIIOau2AXEmZcz3HTcLbfOXg07UGDKEENIsHoj4FRYg8Ov?=
 =?us-ascii?Q?lZVWBgFoYRCI9gRdQLFhkWRetC13vumQ8BRaPMDtEHMXZZtKvgeAXYQtM3Hn?=
 =?us-ascii?Q?KaE7ZPR9XjZwlRk33TRMWF/RCPQbOJGmFqL5zNVF/W00taO0GBLJHr7BkI22?=
 =?us-ascii?Q?4BTW/HuLCMTZwfgRMjlSQQbcmFlsIxirEc3z6k9C1pBr4XSDH+7HqNFyuLTR?=
 =?us-ascii?Q?wBIv+c7pQb6ttVqSQNyoQZJq+z+omc551HX/901CjjdsqRql99m9tD+G1G+c?=
 =?us-ascii?Q?SybElC2Fyp/DmFq49YwjQffCMzVhSUJ2aubo6oyLZi6d01l4ZYF4QBEruwis?=
 =?us-ascii?Q?VMq2Mxs0IldIzPzFzkRxGx3QnljuChdKKzhrkgDsKtARUF9EMCZKzLY++Jdc?=
 =?us-ascii?Q?4pWzWgKtwiEMM7elUqFXMpjc3Qah4iHC8mukV7XBovoncXTqG+d4S7C7E+na?=
 =?us-ascii?Q?7OD4c5X73T8P4XPJGMv7gHUtRDxXQ9T0nfTsFsV+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b094f9d-e52a-475f-479b-08dd0a96d5eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:50.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq+1tlNeYOAQTduTJa+ioKMrgVJXYTZ/vzCal096EEGIVW8Kajmsx0GULOu9SYw2UxBRDvtF2Tu/YmffcqQANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Wiliams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b..cef8bff 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2967,11 +2967,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-- 
git-series 0.9.1

