Return-Path: <linux-fsdevel+bounces-42803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B0A48F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC3218928D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5419259F;
	Fri, 28 Feb 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ies1Q2a2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90313213E;
	Fri, 28 Feb 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713488; cv=fail; b=cb9cPuVnsochV/dIAXs+JxSgExU4Gam/GkuiofZvK6Cc5Baz2z7FgP6JhwaC5qmCCGr0bSU5UUJajqbTa3D7vqvjkAs5IaBW4pm4QCl+mMNGF9Fk2pmSmgmEG52Ki74dPjpTGK1xqAfcxKDKvvWAFGr05KiKThyQcx6eh2cdey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713488; c=relaxed/simple;
	bh=9a+n3SrTCLrMEt9zvuOoPjJ/Xw0Zct/HARDoBi+KPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lIUmbmKgrWVjRZy/P1RoohpiUDAUF4zokufVqTjD1nO6nTYg2vcQ0D8I+p5ghhBp8W0ckcfUsGgGxxLf4bXXqUbKOefH3STRXQUstO5SmKPv7BEXJhL/jxYJAsCWDJdPrFREJvzWdODOyDrki0to+yw0vZIIfsJI1hCghHjK43c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ies1Q2a2; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCxypE8HES5kzkFXnafDxN0XnYy5wDf3XunK6xQU/hPvp4MUqhpeJkx6DYxCcA0vovqptKafmtwU+RXTZP0REgs9P2h9/3jZ8YsLtxj7cHLvNBT+EPFIbGlJb9+o9jlfGeO+dJxbSTuz0OWXZvTbwhEUkFu4fGE6GTW7S8l6/ACjMy6T4fgI8Tb/uM4eBPBl4BpjpH0JRB9wR3HSzjdj5V7x8o4hg6KcKxeNlc9nZt7QxDaAKnpdTiswTrv3YMUIsouz6Ixfe+a+hhK0UnpOw4BpFa+4Z5J2JeoaIyjcT+orE+zwFfIFMufEZCVOhMzBRiuaY2awfeeQcIBVrRD96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDWQqBCKRnZ+Jdrmk+pgS/S7V8wCHFG9mj0EFgLS0B8=;
 b=fxbrTYvf6bnqEhG8kI1WMsJZY6B96wPgE8pP8s0a8xELE/oRiTxO1E5De9wYghqEkgzFvWSrGpFFGaf2eNrCrqFoG1CueLm2hGv+WsyubKwMPoKMgFmM4hOXSJdYkg4eoc5+WtJ1K0iigc83JteB03yAY+nK1A1+eSHo/W8CjJcTdC7mG7xCoa1k12nSOwLuUCBoc/WQxxGs6evWxcTS32hBOPyYS1r8704qTcwbsIJkHkGTiKOWiiKVzIZofKRtAkTqLjfnHdtYPvorEyP6iaaEgZPt449vaxtgRnRi3LNKuKOo+z2Ejfk4hVJ3DjDteOFZaJmuQNLhKdx6kLaW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDWQqBCKRnZ+Jdrmk+pgS/S7V8wCHFG9mj0EFgLS0B8=;
 b=Ies1Q2a2qBsY5IITIrGxysyjOtNrc9xEXqHLYGuAfJuBqRQ0NGNBUEKrqv7VUegL+tY+dHoSCHOoKRa7xJmcDz65gioSTCm6hKZkEUePUip888hzprsCtsI8ZXQEemqAfnDd2Nu8sVH6JSL95hXpVWX/HJgLSh0tRtWDS922Eiql9y2RMXn4tZxZGRIDWM8iP9dbMupSz+SqD+LSQSLXGF27BSCxkgoCf37bOMyUaNGO4iEH+5XCyBtJQMgLTJ2x5bggWycmqSMsbHrhGsjnk9Jw7Hk6CErbW4aSL239wvTkRYooOQoFVXxA/y4wZjG2HlA6ERG22fgkRmpHBvSIdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:21 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v9 00/20] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Fri, 28 Feb 2025 14:30:55 +1100
Message-ID: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0066.ausprd01.prod.outlook.com
 (2603:10c6:10:2::30) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 139bdb55-16f0-4482-dcce-08dd57a85ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RI4adiv3czHZt47A4SjSF62O+iRXr7Q5S+3mBcV0syPmL0mUR1Fv6HpXWHDv?=
 =?us-ascii?Q?m0dzTuFsE1+1f+8uXm1EjjNBhKVl1N/5paYIsAg76Gk4R2m9S2utepmyC6Zc?=
 =?us-ascii?Q?rlVBXYiYg7Qazy8stOZgS2hrb+308YrOnfMAseeYNzPFENFuAqGwmETfFdR6?=
 =?us-ascii?Q?tZWTgncmcEpW4nLdoMyhMVxODXLEP8t3x2r2v9zL6dBJsSD759MAaw3Iso5q?=
 =?us-ascii?Q?gtfGYBA4Lo1ceMxdAPjr5pl+G6xdljcpawbu0Pz2rzHLoEnz2TKbZ2gWm56p?=
 =?us-ascii?Q?Ep7pnddtrdniBK85lXFf4RRWSdJrvqLMJ8cARyTMfQT/CM47nl/8PKqjDNY6?=
 =?us-ascii?Q?AkkOb6cC6948GizZ0Qa5fPJwXQCBu86ZaTVL7rcaoXSMYFHi+L4ZXTt6DDK+?=
 =?us-ascii?Q?Lqr9HKTrg5LXFmVGhbL41zHtO/SAuJjyVz0VkaLlt60ZV6FByqFquiA/C4sm?=
 =?us-ascii?Q?cXh3rKgGGfsC8euQuQL01g7G6H1KJWdO/wIo07SqRswlqWNEGQC8mL3FBGzV?=
 =?us-ascii?Q?nGUY3pzuDD7s0UJUlF6TldAXfP/5Np+MpPqztzeMNI52gcCRhnZk0h5L6LdM?=
 =?us-ascii?Q?tehlOC3xj6a/hvvzZdRVxwqWGKbUn/SdbOkFEdZEM9IsN/Qb+J5hmYcK8M0w?=
 =?us-ascii?Q?2wve86fQqOTIeaTH1MDTmdGMn0tkeX3QG3iqZ1jhkYZGbic5LCGWKChJtteR?=
 =?us-ascii?Q?mAsLdR3cwkXLW0fVd5BDPJWhYKX485az8dC34AUD8Dzx+tjwI3K4dHyYIE/0?=
 =?us-ascii?Q?sI1FTXPXDv8YYd6/PCCakP+NDgCIr/K1bfByvChcIGOAszmePx5dbcsN1z0u?=
 =?us-ascii?Q?nDJA66M4CPkzYC4duwdJgTNFzM4ngmLjClF9BLrZcIh8c49NsupaAe6g/Mu7?=
 =?us-ascii?Q?1D928hjAuq5TlAonZNEi0jo35QeDNJf0/vzO8skuBfWGrHReDNs9nQFKTJOb?=
 =?us-ascii?Q?GdXmodkik1Y3yZF2p39oj2kGb8zfagJPXFuUVlJBbrtKjGagfZzh+OgdnwJe?=
 =?us-ascii?Q?+M70ttD9BWr7HJpKIbJmxV7uLY2a78aVKiQxytBms4rqBhh5cSEb4wco3LYN?=
 =?us-ascii?Q?n9QHRbHIstenHEpKyPwb2DwBAR9eiDjAwpmUpXpFbhZYFCjhsh7eSKt0K+6T?=
 =?us-ascii?Q?eLMzm/ckwxW1K2ihRzUb6KsSX/ia74rtT+VNyWv05nV9VQrUS2O4d9gRraqE?=
 =?us-ascii?Q?Je9MIrFCVGfRgyflIN0LmEHj6yBEQIH4qNRh3bbDRrPBWKwPFBV6NXBQyIdP?=
 =?us-ascii?Q?dSUCAfSq/qVoIvzAxRf5ZDBiF8ih+PfAsMjc007bSBe+JUETgUZciRTXU3J9?=
 =?us-ascii?Q?UxgiqDpn+zooPei9p6KMr0qiwOOm9Qejpj8Vif3Socgnmgqdu39wlkQ+/tqz?=
 =?us-ascii?Q?GmIeaRjuqy15Mh4smCr6f8XiIn7i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvlEG8pXb7TgActbR6oRY3kf14HIEwsWY6q9TamfAxpVk3JyXyqcOfUvhFW8?=
 =?us-ascii?Q?e8bJ19oTrWWxlM0PsJv2k8yqImMHuM/3jEiuAup5D4OPATtn5GziS6kiSONm?=
 =?us-ascii?Q?4NItOROe+YHJTbJturBI0/7j9R0HlX3qrpL3vPkWxRQYQctoOESpXtXK6hhW?=
 =?us-ascii?Q?ypdBEPkC/2pArMgMJcO5BGR5BwkrB+A7/9SiuQyjo58jFQpICxAFK2GSqBoM?=
 =?us-ascii?Q?GyC5c1QrNauKAvQSM23yIEM1Xplme5bj/ZQ+Tfe7SSWeBQySW3egTxdxI0ct?=
 =?us-ascii?Q?0W+gcLLwSvH8LEyW91y9UGhoYZGMVd2euLl3PUZ6mymHFyDtct917D6FsEmR?=
 =?us-ascii?Q?hYMVqc9xZPpC3swEVXle07wNUvYwZQXikIUGidlKteRDUqim1gQjPmkEQp4j?=
 =?us-ascii?Q?ospUtKyAi6oWUvnUfJpnaLohpI3qfY/OByd1dGCRubR3Dv4at1g5hY0Hnj83?=
 =?us-ascii?Q?Uvp3kRWfVT9wobtGxpvpdc5c7uw8g5tPQ1LLhfnOZykXPZDLOHSod4rTk9k+?=
 =?us-ascii?Q?QyAAgPOauI1zhS68wMBQ3ZP6lZDWIowrYnMTHDxb4J+wlPc2eaehD5UXqDFt?=
 =?us-ascii?Q?ceRLYUSDWTjVO7K/ESXjoGA+gM23FIhJPwf1kQdS2QALmhCE+2labIyytuF5?=
 =?us-ascii?Q?54e+51Pl6k/RqMBQedJ0KtZo7aiM4VMrtL6t7dsawGVyhFpK/EgdrScT25Qr?=
 =?us-ascii?Q?1aWD8o5R41kJwX3fTWGUBwZHcuEJX1y1vO1BQjJDwTKpY+wzrt58lGlyExKN?=
 =?us-ascii?Q?BBzLLTZyRLdicCrNqnY0O1wyy4PosIWVfpCafFCzRvwgr1MVq+ElRr3MicIO?=
 =?us-ascii?Q?gujxaoJecY65ozfEM1fd2npubS0Qm+EwiNUww5laKo028e2KlyrxoPAlu+vv?=
 =?us-ascii?Q?fp2OXwerBTLZAmaj8NldRLpiJZYjHjLB4c88o84NdSVB31hiBP6AiKv7HDR4?=
 =?us-ascii?Q?pm+cjFwfH/7xOeybivv7Y0Kpp67YEKtwwkRZx9K19cwK6HmdoAbSJe9tvbFh?=
 =?us-ascii?Q?81WMCHutTWOW4DMKwhM3D/xz0GhiiUH/vD/lmHYBIPR+JKk1FCSUbfWsSVCj?=
 =?us-ascii?Q?KtzNmT5e2cbbtsmCl7f4ZpaSeDfmtW/GDcgPGjLfyhucqDnMWxHQxDROie6E?=
 =?us-ascii?Q?SyZwzmiDFeaKCGjq21dKbk0KNxqbFiTaEH0asrYEClrpiCLXGLK+OJt2/eua?=
 =?us-ascii?Q?n1eoR2PwXi56s7UYIsnMJOEB91EpCQj6a0p3qDP4hVQ5ZYcvCOVQcV7XvnKR?=
 =?us-ascii?Q?/AXEygS8cAmLQ6vblfdJXiZY/ILCFypu7apmOJ1IlnQYmInr6lgGJrcrjD//?=
 =?us-ascii?Q?qj+mdlmokieCvpeDVFm0DFKZih6fPvU6Nmlnf4ekWbDCE0qlCEVO+7vps5lJ?=
 =?us-ascii?Q?bY07Yeziy3rhpeSX1whdaq31H+wP20c15hXY//cpROnBHWVdlFjgfpIWcml9?=
 =?us-ascii?Q?N7O0pufOG0ocJqpvC/Dv2hOT9lm/Mx61yY8Z6Rh98UcmcN9ojKCDYm8TDhjl?=
 =?us-ascii?Q?qMehWjhXSWTc3xi1h6uEzw4lbOUkfNrfm5XUpcPxnLuKNWVSeHDwLgPxotnc?=
 =?us-ascii?Q?3rZBCJU3UxhniKEoBU5ENUc5U/JkY90xACENShpj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139bdb55-16f0-4482-dcce-08dd57a85ee5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:21.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhU/0TIQzfpHPoSDuoOO5ka4oudI/P93YSZqrXt6yNFLvPA6gVI1N9lyIZSdDfZ4UZkpaWi/lDwvYuhuELxa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Main updates since v8:

 - Fixed reading of bad pgmap in migrate_vma_collect_pmd() as reported/fixed
   by Balbir.

 - Fixed bad warnings generated in free_zone_device_folio() when pgmap->ops
   isn't defined, even if it's not required to be. As reported by Gerald.

Main updates since v7:

 - Rebased on current akpm/mm-unstable in order to fix conflicts with
   https://lore.kernel.org/linux-mm/20241216155408.8102-1-willy@infradead.org/
   as requested by Andrew.

 - Collected Ack'ed/Reviewed by

 - Cleaned up a unnecessary and confusing assignment to pgtable.

 - Other minor reworks suggested by David Hildenbrand

Main updates since v6:

 - Clean ups and fixes based on feedback from David and Dan.

 - Rebased from next-20241216 to v6.14-rc1. No conflicts.

 - Dropped the PTE bit removals and clean-ups - will post this as a
   separate series to be merged after this one as Dan wanted it split
   up more and this series is already too big.

Main updates since v5:

 - Reworked patch 1 based on Dan's feedback.

 - Fixed build issues on PPC and when CONFIG_PGTABLE_HAS_HUGE_LEAVES
   is no defined.

 - Minor comment formatting and documentation fixes.

 - Remove PTE_DEVMAP definitions from Loongarch which were added since
   this series was initially written.

Main updates since v4:

 - Removed most of the devdax/fsdax checks in fs/proc/task_mmu.c. This
   means smaps/pagemap may contain DAX pages.

 - Fixed rmap accounting of PUD mapped pages.

 - Minor code clean-ups.

Main updates since v3:

 - Rebased onto next-20241216. The rebase wasn't too difficult, but in
   the interests of getting this out sooner for Andrew to look at as
   requested by him I have yet to extensively build/run test this
   version of the series.

 - Fixed a bunch of build breakages reported by John Hubbard and the
   kernel test robot due to various combinations of CONFIG options.

 - Split the rmap changes into a separate patch as suggested by David H.

 - Reworded the description for the P2PDMA change.

Main updates since v2:

 - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
   and have them pass the vmf struct.

 - Separate out the device DAX changes.

 - Restore the page share mapping counting and associated warnings.

 - Rework truncate to require file-systems to have previously called
   dax_break_layout() to remove the address space mapping for a
   page. This found several bugs which are fixed by the first half of
   the series. The motivation for this was initially to allow the FS
   DAX page-cache mappings to hold a reference on the page.

   However that turned out to be a dead-end (see the comments on patch
   21), but it found several bugs and I think overall it is an
   improvement so I have left it here.

Device and FS DAX pages have always maintained their own page
reference counts without following the normal rules for page reference
counting. In particular pages are considered free when the refcount
hits one rather than zero and refcounts are not added when mapping the
page.

Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
mechanism for allowing GUP to hold references on the page (see
get_dev_pagemap). However there doesn't seem to be any reason why FS
DAX pages need their own reference counting scheme.

By treating the refcounts on these pages the same way as normal pages
we can remove a lot of special checks. In particular pXd_trans_huge()
becomes the same as pXd_leaf(), although I haven't made that change
here. It also frees up a valuable SW define PTE bit on architectures
that have devmap PTE bits defined.

It also almost certainly allows further clean-up of the devmap managed
functions, but I have left that as a future improvment. It also
enables support for compound ZONE_DEVICE pages which is one of my
primary motivators for doing this work.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>

---

Cc: lina@asahilina.net
Cc: zhang.lyra@gmail.com
Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com
Cc: dave.jiang@intel.com
Cc: logang@deltatee.com
Cc: bhelgaas@google.com
Cc: jack@suse.cz
Cc: jgg@ziepe.ca
Cc: catalin.marinas@arm.com
Cc: will@kernel.org
Cc: mpe@ellerman.id.au
Cc: npiggin@gmail.com
Cc: dave.hansen@linux.intel.com
Cc: ira.weiny@intel.com
Cc: willy@infradead.org
Cc: djwong@kernel.org
Cc: tytso@mit.edu
Cc: linmiaohe@huawei.com
Cc: david@redhat.com
Cc: peterx@redhat.com
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de
Cc: david@fromorbit.com
Cc: chenhuacai@kernel.org
Cc: kernel@xen0n.name
Cc: loongarch@lists.linux.dev

Alistair Popple (19):
  fuse: Fix dax truncate/punch_hole fault path
  fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
  fs/dax: Don't skip locked entries when scanning entries
  fs/dax: Refactor wait for dax idle page
  fs/dax: Create a common implementation to break DAX layouts
  fs/dax: Always remove DAX page-cache entries when breaking layouts
  fs/dax: Ensure all pages are idle prior to filesystem unmount
  fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
  mm/gup: Remove redundant check for PCI P2PDMA page
  mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
  mm: Allow compound zone device pages
  mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
  mm/memory: Add vmf_insert_page_mkwrite()
  mm/rmap: Add support for PUD sized mappings to rmap
  mm/huge_memory: Add vmf_insert_folio_pud()
  mm/huge_memory: Add vmf_insert_folio_pmd()
  mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  fs/dax: Properly refcount fs dax pages
  device/dax: Properly refcount device dax pages when mapping

Dan Williams (1):
  dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support

 Documentation/filesystems/dax.rst      |   1 +-
 drivers/dax/device.c                   |  15 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   3 +-
 drivers/nvdimm/pmem.c                  |   4 +-
 drivers/pci/p2pdma.c                   |  19 +-
 drivers/s390/block/Kconfig             |  12 +-
 drivers/s390/block/dcssblk.c           |  27 +-
 fs/dax.c                               | 365 +++++++++++++++++++-------
 fs/ext4/inode.c                        |  18 +-
 fs/fuse/dax.c                          |  30 +--
 fs/fuse/dir.c                          |   2 +-
 fs/fuse/file.c                         |   4 +-
 fs/fuse/virtio_fs.c                    |   3 +-
 fs/xfs/xfs_inode.c                     |  31 +--
 fs/xfs/xfs_inode.h                     |   2 +-
 fs/xfs/xfs_super.c                     |  12 +-
 include/linux/dax.h                    |  28 ++-
 include/linux/huge_mm.h                |   4 +-
 include/linux/memremap.h               |  17 +-
 include/linux/migrate.h                |   4 +-
 include/linux/mm.h                     |  36 +---
 include/linux/mm_types.h               |  16 +-
 include/linux/mmzone.h                 |  12 +-
 include/linux/page-flags.h             |   6 +-
 include/linux/rmap.h                   |  15 +-
 lib/test_hmm.c                         |   3 +-
 mm/gup.c                               |  14 +-
 mm/hmm.c                               |   2 +-
 mm/huge_memory.c                       | 170 ++++++++++--
 mm/internal.h                          |   2 +-
 mm/memory-failure.c                    |   6 +-
 mm/memory.c                            |  69 ++++-
 mm/memremap.c                          |  60 ++--
 mm/migrate_device.c                    |  18 +-
 mm/mlock.c                             |   2 +-
 mm/mm_init.c                           |  23 +-
 mm/rmap.c                              |  67 ++++-
 mm/swap.c                              |   2 +-
 mm/truncate.c                          |  16 +-
 39 files changed, 810 insertions(+), 330 deletions(-)

base-commit: b2a64caeafad6e37df1c68f878bfdd06ff14f4ec
-- 
git-series 0.9.1

