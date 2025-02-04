Return-Path: <linux-fsdevel+bounces-40842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A770A27ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154AD164A16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666D225403;
	Tue,  4 Feb 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UeuzUvsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F821D018;
	Tue,  4 Feb 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709380; cv=fail; b=LeduTmQY8DL4sf8vb5NLtZqJOkGSEafsuV+vb9OcJz6uKyUJns/i+CgOfYHJ22QiBIncjw+a6tngch0zG4XAeMucVkXOtfPmPue+6bSlLMqjy6Zk6KPbss0a+a6FBz+zY83tmYeNa+WjYhUjyNRTwvGyKa1NA6uM84B0/odJ1xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709380; c=relaxed/simple;
	bh=MzggkKOop1nrfgTHbHW3ykKZ4LvW45yib4haa+FBSWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxkOck9dxu8b8MzCJQRBmzC0AgUZpvcXt7OIiiV8b9X6wRfkLWojUAJboZzDlxIeDDjwbMTzh37kuMrk1eNudtgRHo4ZtLLNlBzcLXw6h4KwJj1ixo9rgmmp4ZuRbm9Mu5i4ObJ1Jyg3dkpHi9sYs3LtviRStY4sYGc4SNvHJ44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UeuzUvsV; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNncDq4leDpXispeV8XgA8glYHwBncOAQ/xyxnedFCWyvWk+bTH3GvOY4dBrknn2K/Uqfrwhs5cMxl17jwgGexWTEzdFFpDgKxUIkAWHVn6UQUXPy1ZIulNKxYTnfqJbQfkK3Fo5fAdEDH4niM6myU/HXP9h9HK/5QHKYmVC3YaD8FpeiOspzYjPVP2bXcczS+eXVxK7v2Dxcg9ljbJTFzmrtyeMLBw02xm5uEqdIYku9oOVKHn0PIYsQ9nTUd4+LSkz7EOWW0cfF1ZfMh0GNsH//euNfp2xnNAbuif0eiVxwJFgFvwQ6Mh0sdCu69a58O0L0HhG27VP1HC4EtlMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIFsFkwQqOlhv0D0MCNi+ci6YOVC+qI3Z9fzJ6ddjZY=;
 b=kQ1V181zScj8Diab4JrK9wxBOsBmQXUQxUUU7/OS1YjmYoQpzqE7pESeg6TmfEJKFfI11Q/tw/DyprQhyob0jQWgcEykCk5sTSRMsZUFNkakeow1VecgAoLxWA7la512/PdQ2XGntzBYCGFOMm4+yDoQbhwpPP1YPaEEBysX/EGrMoA0UKaj2D9GInFUitragKpfRc17eNU6b19Pmc5jnyfi5XuAGoa5j+dPJ1XRjw6kF4VlPzw57SDPam7FofgxYBgBv02MCtCjeHkplyZCj6URqi2eLD6QCR63V9QA2ntF/6yT4dunl2yylC4K/4TrW14DTFLrA0F86558UndP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIFsFkwQqOlhv0D0MCNi+ci6YOVC+qI3Z9fzJ6ddjZY=;
 b=UeuzUvsV/FZRT4GLPdp14+mEF4Qrk/q1x6LDL3tj2x3Kw+Uu9/c1RQa89lQQUIRGceAtVmvK13UCCGdut84IQEm5koh8Gu8rkiih84vtyyLLeyF9rkefnB1BZHd08h2RFgtYoDDeuXRZ8MYx8bJ+y0GIaTXkfGAr2EBPC47WSrwzv+9j1yc6q8Uah6KWagSHth0bYRB/ppI3It3vuGxVQE7qyWEpDSm22gKs95t2zxrxa43eMSkePEnRciWlYih78m+gSgQBruRDINBn+1Ib8gDCoo/YzzopdRMhGQR4Fcj9+YbliaiFXIGiWE9uFlQD3qVAfuPpygyxB9p98q66iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:34 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:33 +0000
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
Subject: [PATCH v7 12/20] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Wed,  5 Feb 2025 09:48:09 +1100
Message-ID: <7db953c8cc5a066b4aa23dbdf049c6f35cce7b99.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::26) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b365e0-394c-4b98-4b7f-08dd456e310a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vn+Vix7NJ9uCFxyIiatqGQYemjDceBEvnjmgNsupA9EtWu7p4c+Fi7sGLSsd?=
 =?us-ascii?Q?/2V2yFoqCGvm87Qquw76qGkabU9sv+Hsbgixj7RrLdOZ++MgpEafz5FjgBWq?=
 =?us-ascii?Q?WiNu/tbOZFVlO7VWp10Jut9PNwSM2YI/EBtjQV9tIWJoq5ilB8i/vNM+eySl?=
 =?us-ascii?Q?JbTchSwhMTHdW5NcPZk8BaG01vDiWXhBoZTFJfBy9W6sRzJsVo4FcsvwGKl3?=
 =?us-ascii?Q?fM9Gx8V4sQ54Tw1J+Sehuo2TgLwz+QS5bdXbJrXOsrWDOU4wCbruxaTdQsLy?=
 =?us-ascii?Q?yDPR30mbgHDYlkk8GaWi//NcKVawCyrCChlAXBFId3krXx+EbfaYOTqKhX2d?=
 =?us-ascii?Q?Kaat7Aj1+jJSXowB9g8iqiuygAisw17NRjLvg3A+Km2sndSlGYcdzcZH+H9k?=
 =?us-ascii?Q?fwWPmk7QpatRZb/PnINak07cx5Fa9FjVQzIGVp5QroJzMhiU8AQUc7eytT3E?=
 =?us-ascii?Q?0NlC/PGEWUHoIrOGhk+EDRTBPgVn1MgRTEh4CahyOKOHCSoCHYzwRatAree7?=
 =?us-ascii?Q?0Wa5XiRVxjd/G1eHg2+H5v+U+TPk8p/+4I6Ke1E3NQHOzFW98+bM5xxWr4K3?=
 =?us-ascii?Q?j2e34O97dYpbRG5Zn9b7tT+/M1Q4yijZ/raKCtdE9MGzzBZ5NVUKXncVyyc5?=
 =?us-ascii?Q?5JZxvsWfMGQyOjn9u4Q7lrnssPiAOD1lePkqd6Wtf16HhqoJS2UmcBcSirN2?=
 =?us-ascii?Q?+AV6op8R8JgKH0utqzfjkMKdDQ9bg3VI+dMeu9xDv+SzPgEwfkQpF36OVg3x?=
 =?us-ascii?Q?gGI9eYsH+DFpgXcsw0hzn4sLlRKV9gtkl+yzc5gyUioQV9ojdCb8kaeKpWRV?=
 =?us-ascii?Q?ONvYrodUi0/zzaVSelCSuNrBDgoBOqL5N9CdZqaAgBPPnLAMO8HwZGhWCGhY?=
 =?us-ascii?Q?EgG1WttK4byBB224Qzidd94tQAFXvFAKz4mFKzmPeQd/ItUSor+9hB6isamc?=
 =?us-ascii?Q?RRm8avo0gBuCxJtjDYcw8E1ES4zKa050b8wZW8AoVz6hO1t8kqpWMkgUPDwX?=
 =?us-ascii?Q?BNfUYXgr6BEfoZ1y718O5K25bGPcS+FgOnnqENU/um5Ptd+NapJMSGvBrqPi?=
 =?us-ascii?Q?QOSCfG5EfFtk+u1DOK94eKXTJ3G0066ZMJ6baah0uJILAxp+aZhhn5EHzpYC?=
 =?us-ascii?Q?n9tDc2weeEXxRm/yo/gWM08JNLb27oS2Csyhh1UYFaCY7AAZDKsh41X3agse?=
 =?us-ascii?Q?+vxgxEkBu/1Iga/NlM7Gsz4olK96PrQ739SaHBsAz+zk7Q+zOJgBlC+1pl83?=
 =?us-ascii?Q?+/6CB1V/T3KgcIF8UaClgFAWIwB1uh801gSNmj3WlPZEogqFj42LwYmNuQtv?=
 =?us-ascii?Q?p0/YSjI75zhQLGMRG+bpYdnhsYkvqwEwSGUonR3Rk5kL7853MzosvF/riCB/?=
 =?us-ascii?Q?HflcC6vRPKkLxsZCYb+u6eMnrBfG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUX31JjS5FYA7SYPetpnxfn3Rck8OSDHWFo9Jp9c/xDBMjhATEHr8vBjQvE8?=
 =?us-ascii?Q?QkRN2GcUjrDNkaaACLdLy7kSb3WdpcxprTyUWgyHood6H279Bm6mmM7aDgYH?=
 =?us-ascii?Q?yHUi19KG7Ek8hPJjSI/9Ep0M4/odxRqHEhZW3lh2YZ13ndSG1PJDq/4np/2j?=
 =?us-ascii?Q?KzZlcC+O9d5WdQOr73zIAGVgbPHJnZKJhtNgap9Cw++0I42/qIEwqTCR8mlP?=
 =?us-ascii?Q?oAXXUpE8jUcY1j69+ni65oECz8YbkLykQeb0k7mTEbTnXycwN+fWw0y5mP52?=
 =?us-ascii?Q?v6aJA2rwbB50+oib5F7SVs3IRSkfmsrUIbqZkJZc0+mKgehg4w9kTIpNKbXL?=
 =?us-ascii?Q?3HVQ2Kek0GdfqROgKNLuErxQriI9N3QzCCBmBLfHtwr2Nn6uidutwqia0sNF?=
 =?us-ascii?Q?8d0ZLiiE/1HElOvGOWFWS13U361MGgT8CjHwKyqXtnzDK816TB1KoRkG+c4J?=
 =?us-ascii?Q?PX2ymgJtFQ7Lh/C75NOjEdJ0IuDmWxYB5O+6BYZ11ILfzPQUc+tFU3BgnsU2?=
 =?us-ascii?Q?rSfIvLjdOYWEJiK/mjoJQ6JqUY8DxUy3t32HCqPvSstRLrUOVJETwRj/DCJz?=
 =?us-ascii?Q?fgwSuMtlSljEXa3qZDsu6ABcnltVhVtB5PlK7MhyjghoQvMleKJkr36zd/UO?=
 =?us-ascii?Q?nD+jlB7XFJZsJsxSwPbkHfgxMyp4Ju/34cAHqcVaUtgj8pssLqMiDTqX9iCm?=
 =?us-ascii?Q?i+CT/3HhhMxyBtPYhvCrowID9FPYuT0p6BCCatZYgTT/U0oR0Z4d69+rua3R?=
 =?us-ascii?Q?HIFN72zNC9NHntiUhcEWxHPuBbSnKDjR9hkjAoPqYL0qGWtKK5fpz7LSuI0G?=
 =?us-ascii?Q?vot4oDPaqU/A+epHyn+3gNq/o4iZNhU6ahl486ZDRw9YTatPidqkH1DnPRkz?=
 =?us-ascii?Q?HKDJiP1FEatJZQA/OqoOHkcDhGIryM9DPizFDUZscf8nSjvYwRd4fmWnziv+?=
 =?us-ascii?Q?YvkKGsEQJ7E8gxw3/pYJ4QVHSLZyWlTeuLd2xgzpJDr+lmtpl9oWomROmqXi?=
 =?us-ascii?Q?//kjo6KWQJ9TLvjftDvDYS1PhhrK7BfRDBZ1Jo6RGBBoMhhT1VOgrwu1WfBe?=
 =?us-ascii?Q?ahpB9Q26o3DBRD/XTTWVavBI6pLjDH8mRDSrO8lnn/178C0BflFTqfib5ha/?=
 =?us-ascii?Q?f+RFveawI2P7mRh010iKvmCABoI3sb++qZ/TfXWoy10QPPLcWHlwPfojxG3U?=
 =?us-ascii?Q?KWMKIjS+rVS7v69yBXrTPJEWnulSEklIYTdgc7+9B620pYM80jOavPckfmrK?=
 =?us-ascii?Q?pe92pqkv3XpYGUhMtMQwG9BPRBuX7C5z4nogdY1XBe6i1r7UtOhyNvmtPIh6?=
 =?us-ascii?Q?ABpcjJOQqh8rvpP6HDGwkhjLgBwnx2y7euivx2Ix1xdMf97CgOyKmH+OqGgA?=
 =?us-ascii?Q?atrsiB5Y9mGsXESAcid88NmzKOHt2LvqkEIlXD/xCoDCugLbdz2fAx0NnaDu?=
 =?us-ascii?Q?h4XMX8i41QtW/ia513RWsoXvZS9SgOQdIoXfslQ+vVQp9rHdQNjqbjpZu5Ak?=
 =?us-ascii?Q?z1mP+90zPyGzhlDD0W+ZPaVRCgIa2hWD9/SMD87Q2XufuSvHyAloGEOsIkUU?=
 =?us-ascii?Q?kqbBe5LkKrW/mLHXcewJxQbgK6VF3wkSVrgZqEP1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b365e0-394c-4b98-4b7f-08dd456e310a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:32.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju/cNraWEBsYWJLoHGjgSPwdono/C91e7ntfts8uQinGtRlHMQTIoMeopjIgaXX3DxuBTMmy67rC6fvddwB8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable
mappings.  Recall that DAX returns VM_FAULT_NOPAGE after installing a
PTE which bypasses the typical set_pte_range() in finish_fault.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:
 - Drop entry and reuse pteval as suggested by David.

Changes for v5:
 - Minor comment/formatting fixes suggested by David Hildenbrand

Changes since v2:
 - New patch split out from "mm/memory: Add dax_insert_pfn"
---
 mm/memory.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 17add52..41befd9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2125,19 +2125,39 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
-	pte_t pteval;
+	pte_t pteval = ptep_get(pte);
+
+	if (!pte_none(pteval)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/* see insert_pfn(). */
+		if (pte_pfn(pteval) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(pteval)));
+			return -EFAULT;
+		}
+		pteval = maybe_mkwrite(pteval, vma);
+		pteval = pte_mkyoung(pteval);
+		if (ptep_set_access_flags(vma, addr, pte, pteval, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		pteval = mk_pte(page, prot);
+		if (mkwrite) {
+			pteval = pte_mkyoung(pteval);
+			pteval = maybe_mkwrite(pte_mkdirty(pteval), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2146,7 +2166,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2159,7 +2179,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot, mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2173,7 +2193,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2309,7 +2329,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2589,7 +2609,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-- 
git-series 0.9.1

