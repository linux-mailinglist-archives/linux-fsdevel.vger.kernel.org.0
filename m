Return-Path: <linux-fsdevel+bounces-22570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF043919C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8631D28368B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0923E125D5;
	Thu, 27 Jun 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKZmzpLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B63A1DD;
	Thu, 27 Jun 2024 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449720; cv=fail; b=XzPClCWo2gSOldt7szIICCdcYL+EG81L2fCCN5n/BihiQdhDNOtnr/MIiebUL+YgkCrBKPZ40rON9kJeU7aosmm4Pq//LQ3a9L82lYQuda1fgcFZGK8DT35VjFM9lVgu0DsijNKWClGZsJD7RA0Ch2ltQI/EWGb453iJFLRkBVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449720; c=relaxed/simple;
	bh=tELCw0g60lN4MeM46dJIH1odMeKhLHKsOAI1WHUXWd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnnwQRv/fsrPFFfT87rDnEWPM43GK1nsRcIgMbJPit24tGLv8X2NrEiE8oNqVw8IMlYRnRvuDtr5ZFnlmn+yXe8E6BXyxywJ0mu8G/VGRjma+a6dDuFcpMA5SSMvkXzEupwrFFlf9I26mm80ZL+Ke3gKo4X0YV3mXqISqOWdN80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VKZmzpLR; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPxmlkzGguSOeBKDSjRlRzBYZvyhX1o49Ivq8KTJ7Ma/7Ut58TLppylM6tt8hVIzCFbcImPcRMrmvovuEIIv5e65UCg+aasDzMVUpQRajXEAmdAh/3vQOWNCpiIseuqqXx1wuMuAeWa/+Ep5Sp4G455amvouNpn5S9GYyy9vpxs8Pm3tJvO5ZHh5W6/M3kbWiY3LeUShO79JOZUf5IYyQrCnx7wQJowDs8K5FTBlVlYmqVQo5AFyDSkLg/KuUJ70OLe14Pnnd9AefNdEMfVt4+e8+kOU+818gx+LV8ibnt7VFYWEn4oAUjd2Wh8Ag1pRUS098wM5GFQHuRy9HmQGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELGyXLM0Cq2wdznU6H0lBS0YOvX3MhPfm7JPiof8KDM=;
 b=iQE4IrJhzlHduQjlzroYjhFkfv8o797JsAH3ZgXdlYl4d7bh+llEltbbS74mNYai1LFOyJDiLyqQ4oQ5OiIsczjEVFQOFGPYI9yxF2wfmq0K0dZ3p77Rgx6Tgr2hwz7A0Vk+Jt0y3ZTFPGMqwv8Fl1A5z4pHUJ4IaSkapmEd/YFwTv8hRJ3Kbz62iAPyaAOew+L4zpa5YYRVA+2e5Y59cbospiGHgbhsq3tzVCt3bI+HpH4x+koFA7zMbV63VsDzlrl+asxU8xzzpKdsiywHYjY/54KdHGHF89EXXE4iLkNs895ghC3D5CXRYx+RQZN9o1nkmdoLQkgAxx5wxd+o5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELGyXLM0Cq2wdznU6H0lBS0YOvX3MhPfm7JPiof8KDM=;
 b=VKZmzpLRDExQu/dLY9ZscPjy5gApBh7HORysMJ3miyM53jFhfzIENwMnbGJOEDBxBJ8SC9Sa6aYhokF7cgdwf/0ushUm4Ed6XB4aNsVDNkRlHwFdgsjMdYJx5MPwfDP/4y3uwV/5niar1+AAW257BAWR6is21WlPf8nUu/d2BPI/m+KeuhxWZpWe3xlliJEbCehoqZOwliaaRxRAD8LlH8BoUftF93fSy22uxiy0Vd6ezsoTKSeYgTBMCgEtGK42rHOsXRoS+XsjQCnaB6c611wCNbWG5lcISpoCbczWcTCtVsT5vOrxcgZ4hI6SBJ8nx+YsbtPGrUE1r+UxdE9K9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:55:15 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:55:15 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
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
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 08/13] huge_memory: Allow mappings of PMD sized pages
Date: Thu, 27 Jun 2024 10:54:23 +1000
Message-ID: <eb7e3e2a64da5cfaaa990ec2d37200fadc81465a.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:10:111::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: bba96670-cd2a-4ae7-22f5-08dc9643ce36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rMz4qfOllfl6MVcIcIJSn5oSOmaCRN+QV0HJlp5WBTuLHSmxyGHUE3KPTnit?=
 =?us-ascii?Q?8AOF4/Sn70E6wDhqujfbZxkdMaGBLnbA7CjG9HBDDcKffpyG4eAvSVt2wlMR?=
 =?us-ascii?Q?Om/OwjRESSNYZECvrC0HLkPxFmVBT9fb1yXXdsx+dZI2ZeTCqpOuZpPCMOwB?=
 =?us-ascii?Q?yPcLcyJ9XVkk8f/+zC2RdGYa6AET0pUuSIslPRswM2v4RER7hQ2Tu2M5Yzqt?=
 =?us-ascii?Q?uVBtF+zngV4nmvxjQxmjQaajr6AHnJbxfpAg0GJYgWEaYGL/V9U6ONjRbXsN?=
 =?us-ascii?Q?DJBU0cMEVGTsU7Fk3Nt5dWE0OS+p3ZzRZ/4kQ2YGnm+u8gFynYn8GPs/IdY0?=
 =?us-ascii?Q?JGpAIU0dXZbrV8kgEUaWVtku8MX+xCwobb7ba0dCmLglE9J+hiaDsf+F8pMQ?=
 =?us-ascii?Q?O6KLe0ryuO0w42UoYoPHovioO8Cen1Hm+2MaAmyLbMZyHeu1KMbdwsEjov8j?=
 =?us-ascii?Q?GEqhqm7V+ZSJvq410WOAR/LVkjKPcoxW9SSzUIvgsM6yJWI7irZPoT8agTZh?=
 =?us-ascii?Q?f1Qip6SP8EHyMUef0fIADLxGrZnCgL5edkhGLLc955VwWc+kc92Yr9PTJtlv?=
 =?us-ascii?Q?hSbjkBMMSqM9mtS/XcB9GPvWZ3cVUra4Z1Xqb7rMaiMYWfLPNGrB1kJf/Hn5?=
 =?us-ascii?Q?mVwzFr/hIdFFNKAJKPV6WEZSC3cEJNWylJLd5j5B7dwGFboh0YhJd+DcWdp/?=
 =?us-ascii?Q?K3x7PNjGEcGD6wAdk4ax3bRmTjANEIRgrXPRz4Wn6PYMj2isBV/cFy6Q9iGv?=
 =?us-ascii?Q?taGJTYavNbFfcivVRJMXTyma1TIGPAP9d7KvYP+MUS9j3fpWEmJfAN95FNob?=
 =?us-ascii?Q?8CV8MUyiMmhP/il4SWj9S+YrPdPlyJ6FWfdr9M+qvCxNHma+Cd+rwi7E/w+D?=
 =?us-ascii?Q?dHEnG5+n5izmdFX8G/5yqUeUvVvmHUQ6l8gt4CvtsjtWgZFEOXueZtlW7vuj?=
 =?us-ascii?Q?6KRwewqli0KjcS8V7jzbb7WSVKOIzU3ibpPD/87KCcwHEtCnGleYnJmYEzIJ?=
 =?us-ascii?Q?JY5SUOxa9y/0DqLtsKRus9hrNbwhss4OplS6hPkUfgPH76AyFD3hLdYvcLin?=
 =?us-ascii?Q?yi5WVNw+bL7ZbQAn+L58nTW/7bkpgIB66n/YFJQUyzX45ZKnAKRj+WOdL4m/?=
 =?us-ascii?Q?s6xwexdTQ8kZ9977QMZ3yasxmrcdstFnOCD6STEAoEjE5zd3MH0Rc2dheD1/?=
 =?us-ascii?Q?3Cc0+hBBGNQZor6xvqilEixDNproSRbnwRMCK2PVQFdrbl5xgbZ9ntCdfxOC?=
 =?us-ascii?Q?VnOhzdZ4HcubqMfm8g0yc3w4XD2dHu0jXNvlnk6ue4gu0TAg3yOCBXlWhSC9?=
 =?us-ascii?Q?egomegPk+FGZWQkEExfRbwMUBrJkVofq08li9XCg/qBjrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8dpcV1iU12kDyqeVQWbA3AwxyrevQihuWYk9QJhMeBaWOtnocqkHU6TkP5vp?=
 =?us-ascii?Q?jgB8AgQFXV377ForlLsHvPb5oHRJti9YhbfeFw3mF1CXn99NYNHD0M7fCdXp?=
 =?us-ascii?Q?sXp5ki3CJjrSAtYoaoigEBbqV7BFlrDLkkCVp40GiJ8Dz87lCPg5HNIbw/D3?=
 =?us-ascii?Q?m6osgrcMl6BjeKINf2Au31cDalT11/Zjj9K4pPR3BqajuuMS9DcRqNhGGBA8?=
 =?us-ascii?Q?I/8nqhhsPyJZq56xQQpQGuIu0nf0kVdM/NI6307xMQrT0ubrf8FPBJ8LGqdG?=
 =?us-ascii?Q?2TqCurtRPPxwONBTxG0FqKcSSzfhVk5tpgcZs1JyZh0EE7HFNaIo+9nr8KHM?=
 =?us-ascii?Q?L3RU63UzbvqQD0tm9JFCaSN0CL9E/H+Hp67RJftHWsc+fsZ1iPsxATa5ullY?=
 =?us-ascii?Q?+FDDZI5hnphDEf02UYtM2qOGwKBqIB2fl340bCYb92kh6zjTUr9kTrvThsur?=
 =?us-ascii?Q?sjyphh07ALezlVpShHTooenTHuNvO9JQrJMau516Zfz8AmkJq6SbCdNaM3Oo?=
 =?us-ascii?Q?5l05ZPSbcsnhYh0V3zR7IaJ1ff+oHxuZFrXGVXM+PTMYO21LguKYDkTx+478?=
 =?us-ascii?Q?sSFnXG7swPHjZSgbI6TvhwbBrfll9VZdTpTe9L2TIIxGL8u5LOhr+5XqrvJD?=
 =?us-ascii?Q?AC0TDKai57p6QPn2vGt7yKdPS0iI4jAk17YGqkLYNO8N7yr6HEVFZyD8QKgu?=
 =?us-ascii?Q?/B1ox99xbDtx/Jx+/S1TIDVjuBeJyGtTxKtkvAorOge4oFVsWOWmJ+5YD9L+?=
 =?us-ascii?Q?Gytg456gnWG4D9uuXhc7csOLnbkNCa8fpPoBVlfLZ+vjUQJw4R23OllnjY2j?=
 =?us-ascii?Q?w+KdWeC9jEP98qUyDHRkXYbpqMj95gJIx73/hJwEJ/yOz6xFcOONlNYjkvE7?=
 =?us-ascii?Q?rsO4MR7Hl9VJ8ujKVbNrYczRY1SG2oJ3DRTIZ27fJNTYuKDy39znfBL0Z9DR?=
 =?us-ascii?Q?srvEAqUURkyjvJnLyu2OGbCxpNPJns/+KuC0OzJs9owFCox8YEV+n+0ix2gV?=
 =?us-ascii?Q?e4QJp2BvrjjLLIgOkwtyePzZktBCa1fjPnEfF/wwsZKgakGVmuDxwXuHXwrR?=
 =?us-ascii?Q?wUJiBOFIu/1DO3y12wq5zVgL3T7u1+h45cVGXKkoHFmdDGYpkIaKA+K78+p3?=
 =?us-ascii?Q?EU+PD6SPzwGqV8NvVu2myUGUNER+Q4mTeUftX9O02EIlB0HnkPN7ldcApNTk?=
 =?us-ascii?Q?8qYDLh2r3+mxa6VMHlmIK0oE7qOoqQYnel63KjlBNNgCOohi8dT3QNqNiFzI?=
 =?us-ascii?Q?4at8hihOywcwAiR1OIhH2VTLXak4AyiOEVWBPY+P+xVvKWS6Eo7wEL9LTncx?=
 =?us-ascii?Q?zVKHZGhp7tRzf0v0+nz7TKuKizTw5cd4XEv7FOQT+sB7Gu8XMgbbxV5DmbQW?=
 =?us-ascii?Q?mloXPGONUwVvtOwtsXdYjG7eTTiXe0O9qkXFqrpuMnPHIGVc+gzseLJqn3E0?=
 =?us-ascii?Q?55lz9TulFwi22Vz4IWQWpTC/bo/h9zahF10rlLzXlbo80sjuvpeBwL2F5wOd?=
 =?us-ascii?Q?l9Bz3Mb3TlcrQ0Mqo0cRUDE6Nx95Sld0LYPIzMK73VUw52CqGFTpRE/NXp1W?=
 =?us-ascii?Q?vPsBsyhOHzScfQiE+6xOZYVJWs8dROHgUT5m33RS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba96670-cd2a-4ae7-22f5-08dc9643ce36
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:55:14.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uCbDxtUlB0klJGjloN6NA003Q5dpU0Ewjx4TLFfVzS0yT4d9Rm+IFvq9CH+xf2vUGJRyewEJBu0Ei9t/LSBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce dax_insert_pfn_pmd. This will map the entire PMD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
simply inserts a special devmap PMD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 70 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b98a3cc..9207d8e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 
 enum transparent_hugepage_flag {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e1f053e..a9874ac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1202,6 +1202,76 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PMD_MASK;
+	pmd_t *pmd = vmf->pmd;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t entry;
+	spinlock_t *ptl;
+	pgtable_t pgtable = NULL;
+	struct folio *folio;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	track_pfn_insert(vma, &vma->vm_page_prot, pfn);
+
+	ptl = pmd_lock(mm, pmd);
+	if (!pmd_none(*pmd)) {
+		if (write) {
+			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
+				goto out_unlock;
+			}
+			entry = pmd_mkyoung(*pmd);
+			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
+				update_mmu_cache_pmd(vma, addr, pmd);
+		}
+
+		goto out_unlock;
+	}
+
+	entry = pmd_mkhuge(pfn_t_pmd(pfn, vma->vm_page_prot));
+	if (pfn_t_devmap(pfn))
+		entry = pmd_mkdevmap(entry);
+	if (write) {
+		entry = pmd_mkyoung(pmd_mkdirty(entry));
+		entry = maybe_pmd_mkwrite(entry, vma);
+	}
+
+	if (pgtable) {
+		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		mm_inc_nr_ptes(mm);
+		pgtable = NULL;
+	}
+
+	page = pfn_t_to_page(pfn);
+	folio = page_folio(page);
+	folio_get(folio);
+	folio_add_file_rmap_pmd(folio, page, vma);
+	add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
+	set_pmd_at(mm, addr, pmd, entry);
+	update_mmu_cache_pmd(vma, addr, pmd);
+
+out_unlock:
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(dax_insert_pfn_pmd);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-- 
git-series 0.9.1

