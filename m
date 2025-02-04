Return-Path: <linux-fsdevel+bounces-40845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B75A27EE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822943A747E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E8225A59;
	Tue,  4 Feb 2025 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSwwKVID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D56225A29;
	Tue,  4 Feb 2025 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709390; cv=fail; b=uU8c2MBC9PDKIPfNtrKG/bUxoFJYclWD0KmmsDgSgno4MS8o0g98gEB2gB8JC5pdmZ+z4phz+kNHeh0A1DYAbqikC5WHXZKzN3nGAJhlpHLOc6wsxIB7gLbQgabDPokSkQgsUhO+F38fXAnkZ1dwgya6KeS414TTjfCzjP1ofGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709390; c=relaxed/simple;
	bh=Q4vRgF8wtCAxRK120ljW65SjNRrMRwaXioe9cFNLY2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2MfMgVa0vrQS1aZsa1BtRdhSVIieMpApfavCUKfSugXND0OlMG9H3pH8FN6gIYf1icTPOT5e4Tfm8wRfuTpqPfgeD8VOyzwidhzfquX2XCpA388TBtq7tEb56JT9u53z8W8PbvWim2zIdAT4jmPOZN8oWSt8D1Ng8t1GYIOEYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSwwKVID; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5shDIP2AUDF91U0yODxYNe4TRw2vLF2atv5TSm4HoZsLWib+BX1EqJCZmZNorYB/hf7iFyYvgd1/+6Fedi+ZOZAMu1fdmHlOu7Zyz835HyfrySKop53BFHT45CbdTCyHjEC2XV0ItuPg2zhtnuZys/KaqbNlBkYItVeDgaQIvCjPHolhzSKpp5Y5O9gE3oIuz3XuhytKh5KgqhmO0bjmZwoGUhY7HFJcdopkZp7jQdtYbD10+9v2BX0gouQTvxBNwqzrar5xsSPk/5V4ZvbkKX64faMFwxLqJiBMceZiNjXcjIGy7K1IxOvHQBvGt0YGwmkjfmqWoNvZz8aD38ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAG2pC4wn34w/IYDUy4du+dUC45w16AMiF2TUnuqg9U=;
 b=ifycAn7oMqgZ1gR7z7bsB19hnZfj2RH1pw/dPazCUTSY+DHm+zwajfcxprBL0yThOMImqtYXx07yIg47A7cnNRDGN9us4a2OcAS7ZP77DdX+/H892RtV+ANVyejFdN2pS3TZbnEGgTdxjEX+dJ81ZZqMBGuGVSbd1b0u4kXFvj/VZjxTHplyig/G+yX5sbX3KFvIfC17SZGxHXFHNufiVVzJcEGdvYdvlnwlImYM81q2Q00oa7NAcqXkLi4yQGoniP5+YRo/sjOsAAx14nj5Xz+Mb22e6+r7yfvWouzUS44fOxhKnfJ4gRDLeLLEOX1LmXsNS8O2XMYidRmThnvcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAG2pC4wn34w/IYDUy4du+dUC45w16AMiF2TUnuqg9U=;
 b=TSwwKVIDPycxCG4dEpTyucM4WZtS+/WRlHMnDr6rxyxGdZ2uzSUrwbrC4XRVU1TOYczEXsJ/Ik/PJDSowHQIrexRHjeA5vBdLeCJUDwU6d5nkRt3NIjqgkR7x3qM046GSoYuWzTJRKB1b06bHoqucqAPacOuXbJyVKxxVIf82H4XZ6BgKb3kd9zPRcTh0BGdi7FJ12Sm7F4nF+MJ4SQOygavAHm9iSCGerWpmozIOQPmH99pQ57ZmwS1Mz2UObsLLjb376I4Z13MHUlqV/0dB7RXrkzdtUX8cfj0Zx0PaEcDFP1TE/Qr5RIyeK+Nmkl42vsOG5gi/WVrJudqPb5qPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 22:49:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:47 +0000
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
Subject: [PATCH v7 15/20] huge_memory: Add vmf_insert_folio_pud()
Date: Wed,  5 Feb 2025 09:48:12 +1100
Message-ID: <ef0f8d6a6fd340531613c351c99c98fd6f94ad93.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0028.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf5cbb7-c9ac-45ed-8a3a-08dd456e3985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHgCqeKxkIDRJqlEScjl3mdrlvhIWjbCp880T61f/KJxhuYP28xdDxkMVf+a?=
 =?us-ascii?Q?CiBqabw9tEeXbNzifa2YUbsLBHa/wQv5ktDMCx24MqRIzYs4LTrNuCE+QOqq?=
 =?us-ascii?Q?pgiNbyjAkpzj/nCug9z74FVceEydGYbjKN7DMfXunHrIBw1ftL+jDlmiShcY?=
 =?us-ascii?Q?OPL3D56J73MtxbudnZvH6gDd+Nclc4EjqLWgFl2aR/kN5gJtFIUDsQPFDj0+?=
 =?us-ascii?Q?DEYfUvxvbxlfEKaN7kiMpyA+aQmAdHAmEOX83NY2lwdbuHAGhr7fFchLqi9X?=
 =?us-ascii?Q?LfyzKIoOEVPZY1SRlrZyaTXU6fwAHH9rdCAVn8kkfwBJhh+49NKUsWttXoUs?=
 =?us-ascii?Q?c68Xl4QkBAt8JWp1puIWBR4jqvBqPNMalswNItfleUsDf0dmcsuVA4qDSNut?=
 =?us-ascii?Q?1wgLi0CyehzlphRyCErcGQP2EgjJNAjuNNqaGtyGj/CvO+AXWJgGYxvDoOPl?=
 =?us-ascii?Q?z21TJY9nDLrsr3mYWNktvlpTIsxZs5UXb77tmTL6IurEjMBC1dQwNUUN3Skn?=
 =?us-ascii?Q?Im4w68ltJiDS2CWCKhs2cYDXreZ9rR+dLQHMrKMzgm3RjxR6DC1kRh7HOc4W?=
 =?us-ascii?Q?bIsiuAmiFfkxeRS1+RxKJYnBdF8s06FBOuD7sfqO3XfdtJ07IdwkKwym0Fa6?=
 =?us-ascii?Q?KgA6C8Z0Nf4q83hTJnoOf2SuBvMtCaQPWpKKsYeT7JHi+7PP6BGB3+WWBDzC?=
 =?us-ascii?Q?/QrrY1WtWvUNDJXBEv6ZYGZLbpJpO0HYWgwBF0jY0CSs0WQiIi9nILSuznpD?=
 =?us-ascii?Q?2JVZuz59U+8tEC8Qvl/dPzb2sYrpoxs6Ov0RqbPTYszE0OeNtlb5onGukFWT?=
 =?us-ascii?Q?ILkwN3JPJTvKg/hZ3BHKQc5mpnuFXmzSVYSvKJ6bJig8qafwnt51F13croRv?=
 =?us-ascii?Q?f08ou2xYNfj2fgeThfzboPhbttidnfFWdjJpxBGNhJbyV5v+ggkLBYJgOiTX?=
 =?us-ascii?Q?wvNQMLmQKKnzhwERaxq8QXcFaEhjVmY2Z0yk4FamCi6TO4INoJ0/nssJ7LPb?=
 =?us-ascii?Q?Upla5dCRFa4J681mGi7QG05Wzf6ViiKWejjY+PlYe5oqk1Kcc9hps0xR4OkY?=
 =?us-ascii?Q?ZGCKTqlSY/f802fWaH+m7MorjVlyLp0oAFWone6r+HCjm8VH2EVntiXSGTxv?=
 =?us-ascii?Q?DuIlr2w6QFdjxz/gEgQGAtSb4GnTcMxaM8K96U0BCeFBM5YJSGy3dOmMJb+D?=
 =?us-ascii?Q?Fx8pQl3VDpeVIhdX8sNJ8H2Cd22LPhx2XHWkUAZaX5/+55FrQ7RbXWTnRNAm?=
 =?us-ascii?Q?AEbyb12yp+cyQsnlrf50RzoG8e9/NGiUK3/9Z8gA4MKTVvLg/hsFvLDYeZoF?=
 =?us-ascii?Q?HnA5MMgQDn04BrUcCXJZ80DkQiLwJR8oAzQkaEXbmFk+gTdWvaPZpdP+ghXU?=
 =?us-ascii?Q?ip3jQafQIM4zMnPFPNOTor9wOXfC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wo+ZnUdR1YPxGk5cOlbULInci9DhTciy3Kp+vZBKZpyPC8pBBvaKC54wdnyd?=
 =?us-ascii?Q?/Ha+/i8nA6lie9Zx+2qvrVRcc1r3XHkeQQRoRWD0zqh7FZv5KyiCTCN9k6Rm?=
 =?us-ascii?Q?YJcBsXMiam2t4q9BRaOn8L0Je+hu9qjBkbstBcJ0ZHimpS/knJPvsBxubzS9?=
 =?us-ascii?Q?dTXQqBG2DulGxNvi0QmWvjuiyii69wFu7mewakHaFOd3MkxfUQDwdqgHvWDW?=
 =?us-ascii?Q?TRxJ8UHL/WU5MymeVRfXWcCDwKIJiwawLLvDjI5i1+LN/oWMHLlR9EcnDbks?=
 =?us-ascii?Q?W0HcA0FI06gzm94qFlxmNnZj7pYhUxQZM5VBryRlLBZ/018pRy35gK6o+58z?=
 =?us-ascii?Q?xan7XfmKVSbDWOqahq3XCr2atR4CKE5M/Il41dMgZD+wnkBXWy7BO8RsQ2jR?=
 =?us-ascii?Q?4O2/o2GxYyYoOhVNt3dsV9CL6FonbujVt8mg/sNZAm8SRhvHYZ6kMSdqurID?=
 =?us-ascii?Q?bihKLx8Qw2Xy1ha6mMB2XNYE22wBIYFNbenXmEcZ3I7LfYOmx6Hw7obtqthN?=
 =?us-ascii?Q?RX9ZKOFlxJqkPg9WVkWMfyvYRsJUu0y/+rO9wGsPZYNgrEYBZO3wqZynSsYQ?=
 =?us-ascii?Q?OWC4lQXIrkFg/iKLKvZj/37GAgKdQG2ImSONrVlCDcDOYZrF0oMxjpMLiFJU?=
 =?us-ascii?Q?pCu1Ac2QhvldPx2CQUpcOlqBq7XA64m+2ai1VIJ+JIXYQ5Ur/DOBRlwPP7Oq?=
 =?us-ascii?Q?zKc5OpOP5d0uZFVG1VpjKJcrQ8Vl7aKtwUyKME8JS1bhPFZfG7cgwiALgnMU?=
 =?us-ascii?Q?ivyDpd/60dfZqCsAUwUHh2iWzpImWaA6acC74M1OHGA0V8uc8E8bmyaTcB70?=
 =?us-ascii?Q?DAGtk09Z6RiyimLaQjMdz6p2tt4o59VDDptwxQ7qjHvQ8bnB0AAPPXSJSJHL?=
 =?us-ascii?Q?UXAyvrDOunN+i9+6WSFK0ayNVzWAyS5VAByymj8LPWsLbIU6V3IA1vb5GHqp?=
 =?us-ascii?Q?vWtFss4gE4NwQWv83tTrKOUsXPKoapJjEj2sMu5armVtHpfEn9RgGRUwPkLo?=
 =?us-ascii?Q?l57AL3iBAePVUKxGPe7EeXluGIGX99jDp9AWq+9/Es/FCcA7gTFwCaOZXBDw?=
 =?us-ascii?Q?eomLcLkogAe13YBPcFpnknLdaYJ7LDMMdbdKQ+41gAXc+c2HTaqJFVJadq0N?=
 =?us-ascii?Q?0e5rxngEHeODF+gPmQ8yg0ll7epXhMmByY8nGjEn7ZyJYQBFM9ah23Q8AiLC?=
 =?us-ascii?Q?c2jXLtNMw07zjkF5lyMKj7NyiHnHiJacKrOw3itSG27jZEjyWqRe0he+6rJ5?=
 =?us-ascii?Q?A5ETrAcXYrRQF5IQLe8go0vvenaoB1Wl1rlu+8lWKoND4KWD6IfMXtY5rAKH?=
 =?us-ascii?Q?Ub7IS+jD46+RNFMQPgDU1CuljLCNzrtpc29J4oZUypwrpe/wxXgdBRLw1Lw6?=
 =?us-ascii?Q?ynbN4ljOExtbJCufv0W49Ai4JXX9kiucjWRPzpqcX49KOaRhfiAr4tUmGomr?=
 =?us-ascii?Q?uCF8IektU+dUYhnkt8Q5aiUl4EXR8bdcPnF79pzOctjUUPfFN/JbwmvduAhX?=
 =?us-ascii?Q?+IS5aFwAMLI+CfY+mKkRiQ1DU+qVtO0SuokoAC9CLz9y2E39c9W28DAEvZvr?=
 =?us-ascii?Q?ulIM/xBWKxlPV7QV1LTJOaMYkERtXMuYvPsXK6xk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf5cbb7-c9ac-45ed-8a3a-08dd456e3985
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:47.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQpce2HIaa7/FbD5CvGwVuUCpJBUE+yOcTDCqtraarNfF0ysLkRGTw8jr5p2ahhrvpCjrGfU2x8s2Oo4tYwUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:
 - Added a comment clarifying why we can insert without a reference.

Changes for v5:
 - Removed is_huge_zero_pud() as it's unlikely to ever be implemented.
 - Minor code clean-up suggested by David.
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 96 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93e509b..5bd1ff7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc..a3845ca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1482,19 +1482,17 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
-	spinlock_t *ptl;
 
-	ptl = pud_lock(mm, pud);
 	if (!pud_none(*pud)) {
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
-				goto out_unlock;
+				return;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
 				update_mmu_cache_pud(vma, addr, pud);
 		}
-		goto out_unlock;
+		return;
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
@@ -1508,9 +1506,6 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
-
-out_unlock:
-	spin_unlock(ptl);
 }
 
 /**
@@ -1528,6 +1523,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1545,10 +1541,55 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
+	ptl = pud_lock(vma->vm_mm, vmf->pud);
 	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
+	spin_unlock(ptl);
+
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
+
+/**
+ * vmf_insert_folio_pud - insert a pud size folio mapped by a pud entry
+ * @vmf: Structure describing the fault
+ * @folio: folio to insert
+ * @write: whether it's a write fault
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PUD_MASK;
+	pud_t *pud = vmf->pud;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
+		return VM_FAULT_SIGBUS;
+
+	ptl = pud_lock(mm, pud);
+
+	/*
+	 * If there is already an entry present we assume the folio is
+	 * already mapped, hence no need to take another reference. We
+	 * still call insert_pfn_pud() though in case the mapping needs
+	 * upgrading to writeable.
+	 */
+	if (pud_none(*vmf->pud)) {
+		folio_get(folio);
+		folio_add_file_rmap_pud(folio, &folio->page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
+	}
+	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)), write);
+	spin_unlock(ptl);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -2146,7 +2187,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2646,12 +2688,23 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
 	arch_check_zapped_pud(vma, orig_pud);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
-		/* No support for anonymous PUD pages yet */
-		BUG();
+		struct page *page = NULL;
+		struct folio *folio;
+
+		/* No support for anonymous PUD pages or migration yet */
+		VM_WARN_ON_ONCE(vma_is_anonymous(vma) || !pud_present(orig_pud));
+
+		page = pud_page(orig_pud);
+		folio = page_folio(page);
+		folio_remove_rmap_pud(folio, page, vma);
+		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
+
+		spin_unlock(ptl);
+		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
 	}
 	return 1;
 }
@@ -2659,6 +2712,10 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	struct folio *folio;
+	struct page *page;
+	pud_t old_pud;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2666,7 +2723,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	count_vm_event(THP_SPLIT_PUD);
 
-	pudp_huge_clear_flush(vma, haddr, pud);
+	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
+
+	if (!vma_is_dax(vma))
+		return;
+
+	page = pud_page(old_pud);
+	folio = page_folio(page);
+
+	if (!folio_test_dirty(folio) && pud_dirty(old_pud))
+		folio_mark_dirty(folio);
+	if (!folio_test_referenced(folio) && pud_young(old_pud))
+		folio_set_referenced(folio);
+	folio_remove_rmap_pud(folio, page, vma);
+	folio_put(folio);
+	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
+		-HPAGE_PUD_NR);
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-- 
git-series 0.9.1

