Return-Path: <linux-fsdevel+bounces-38821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84628A087B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D08E3A7A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3620C02B;
	Fri, 10 Jan 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="glHJs/oT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D3207DFB;
	Fri, 10 Jan 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488965; cv=fail; b=J7fHMHYH19/MZAylna10cZEzmvaWvl7Wi/YE+5BYVxtO6aTNsJZELGip7MTo46UTP4hlIM8QO0C24AuUo5NRZhd0pAI8K8HSWb/v5l8gA3wTBnFJLUOBrELjUfqkdR0NfKywprHbHKhfN1/vvw8RYqe79z6BCz1eCbvKaTZZc2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488965; c=relaxed/simple;
	bh=jRBao8kcBtOyZZKu1nhAzXfDbgh4ucd7upLjwsFz6GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DssWqHybJQsbXfFhvWqDF8WucHe2PBUKNjCcY34O+KjWV8nTLPs29klVtsdk9LrOt3wgznDapJPK8l3UpJuzKRTQGLt4hhQo//CyO+CRDyOMcx5pBro+YfY0zeMVixZHEQBp8qQEjjc/IwhH4G7kVsT+Gw1WJPKeJxQ8B7N/BtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=glHJs/oT; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJTb5Ip60sL5Fx4Xa/jJg95JhtBQqJoyskIPAgUuO2uhR+53QuygAqpJcfvTWetlXl/q0J37/V5LiSmPDsMjBSiG3Kj2ne/L1TAVQR5pDx8of+kmX0aDsZ3ui7RO75yfSpzHCkR553/+EkgHwZk9vLBbfg27b+8635Ik9W6PKqyLJJltn5lbuaSbNAGZKcW7T4aIWPbKIpbH+4UTpWEYQkGiz1UgTSMp4R27Sd9SZizwibSXlEotq55iTGXzOoUZhG8UMI9klfnMFz+yTYeerRaMxNxltNCU8DcI20IQdaSnT2Q/l/Mz6+vKfYLsapX5OHa75MlO7RF+zrgW5vZwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaV7+Qz08NZ4CyqSz0ni0zOI32D7DGy3IeDms5nDk1g=;
 b=vVgXHTmTHC+K3Hveq21q4VFXR8bng+1fj5HD1ByQiGv0zUp2mGf1WI8kwqtgPV1w3EJlNFJWwCs8VKb/1hG6iR0EoVB4gl0Xw1bbvXARCp10p+oJQpd6NTIMeSEytfbU1yuQGQX040Ggf10NM2aTNerxPeYZ8uqiWVGW4b1EhGvWDx8GMcRcQmkN9MzMLZOzzKmej7U6+dBQxen3BCRxaZ3uRiiJAPSCSGrOmAMtujWJiysuMFIZl7E2XDhqIE0m+5KYOUcgi1wqoN1vTDjni6e9UWimq5+Ot8rgqx3BA0XAjK7p50OaLOcCCc841QYdAaTOIOHtM65B9oay0CVoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaV7+Qz08NZ4CyqSz0ni0zOI32D7DGy3IeDms5nDk1g=;
 b=glHJs/oTXDvrQJrYprVGcEodBXCjUxnqRtRnzMCgJrC/zmYfZf4Dlvc7HXw0DzswJPSVSQ1cO0HF0YU3ZKt0CfbzZnJuZsyCQQKbdkTV+iFBkihFwWiAG40Px4mVsGWmI2mvdh4rR862wvY3+ecRp59I66TsFyBZM5i7YCrNtJkw/PLncGT/GYyckCS7awgMKEmad2OnwixgCV7CKkpATxef/bojnfpmhWRHgwin3YMgQySp6XpZnM3C4YqiOVs4LeUVDphrByL6hij7i3H9+ySIe7ZcmIoL8+/WHsTTZ5s6cZwBRH9BcsRXt0VlCbrINdjmrCH58hNfjjd2Wt0l7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:02:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:40 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 15/26] huge_memory: Add vmf_insert_folio_pud()
Date: Fri, 10 Jan 2025 17:00:43 +1100
Message-ID: <60fcfaa3df47885b1df9b064ecb3d4e366fc07e7.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb4a122-00ed-4c5f-24df-08dd313c63a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6yWKBGsW1wYjTL4yu4YkfiOwWOETa00YGGWVnFn1amPCB4ALPZdUW0yPMZYn?=
 =?us-ascii?Q?cNSFSvdEKLvgM8p/7GWHYgdyQ0k3mLdY1pVF/BuPM+GURxtIUN+YhV5wxqeZ?=
 =?us-ascii?Q?JmqFsKhiGlxarVjp0zvuOCAERloNIk7YXz2Czg5BDEikddnyCW/7FtGyKLv9?=
 =?us-ascii?Q?b0zhNx134U7FtvkyVeaWisgEmTNebgc+uFk+ulUYdpExWeUFJKrd+3RsEViN?=
 =?us-ascii?Q?zXMHXp3LRAwaW6EIuOU5/wZ8AoB0l7mtbefeJPoEuyyrGpuIURxeXw8Dnh6q?=
 =?us-ascii?Q?qcXHc1cA2Zve2/dsVhu4zxSJ+aZcqDBsp3RWMYqra6DPcAijdZzUY1iIRKii?=
 =?us-ascii?Q?TUC7vDmwYMjOKyq7qMxyKW01zK4Zhmuh+KUvWy91YGblkOBxg8p48eVDAb0C?=
 =?us-ascii?Q?4cLFzz4k8PVZsBLUv88nYD4I0DJonhhjdeg82fkLObevTW+fTY48LIgzUizH?=
 =?us-ascii?Q?lSi29q0rVRYmwMfMfpVQABlBTsE3+ooyRauOlzep4wWkbfzMTlkE7AxNu5oz?=
 =?us-ascii?Q?AP7J8fZZA+FrnLEv0ceMrvAYCHXy4NXJQEagKyo4pWY+guAu6ecAVy88AIxr?=
 =?us-ascii?Q?veqQjjYZcl/1nQ5hiIv02e31siYTyh0lanmlLuT30NttYXyH+oFs7LInkKbI?=
 =?us-ascii?Q?BGGa7Fo2FTj8i1gYJClxapWLBXyE7ijbZ7SHDZKLelqVBcS3R6GS23kmcfZS?=
 =?us-ascii?Q?GTINdyyVJWQA+zcmcqqIrOdr0t1K8YrBmSaC5izxw6nHSVKWoQzEv8br+wCQ?=
 =?us-ascii?Q?t8YCgTXmHIAGpoQvgetN3lVd6iP6jDH8lXAPVDE2/r1HNzn4kE2mXiS0Irvw?=
 =?us-ascii?Q?xRSVVwUOypC5NXQVp5b5m4+1hh1MAwSPmtkeBOUWOI8UZE+mlpF7570zcChS?=
 =?us-ascii?Q?YallqLeTjvQI0vZyVmXCsYmZi/CGQ9yC+Ka5/uEaCRXL4lXRspQWToFV2NY3?=
 =?us-ascii?Q?XcuYGDT2sfgiXpRoG/jONlb/ZzEjMPPzm+4dHFQHskKDEOWK1H5KV1w1m4fH?=
 =?us-ascii?Q?wcA0jamPF/egIVSefsjBSlHsqI24C2dKY3UQ3aEumFPfxaNHRVoNGeMzKznS?=
 =?us-ascii?Q?BHdwe3qWd7yIz86ZaJPrbxbIdy/VmYws2NH4Rglq5WTOglVYIAUPOwV9YRPV?=
 =?us-ascii?Q?6S3FChUH2RcWo7na20ys1Us35gDjPEzE+t8wm+g5HElJkpEvD7qgeDCsmBBS?=
 =?us-ascii?Q?snz2qxPW18oUU0NFzwYCBIDiSBqBuXT30oi58emtCUw6DbOKPVeFRWRLLhIz?=
 =?us-ascii?Q?wv4SbebE4oy0GJd2vNMkFBs7Ar60DMegHnmYAvKBGyB4Wn9gwfrPid9xUrgp?=
 =?us-ascii?Q?LquLzvkC1qH6oqbQ/qyGAEdVFOHA5aW3qdH2ypPQ2pnN/cvSeWRAK3Vnf8Nk?=
 =?us-ascii?Q?bvHAyJo1xzWfW65lYjBUscXxt0Gp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0S/uFECHFZpJvzvwcpfey1+iaBSHsAqcIB1nGNEAyk6+wb8uFn+lfPjiBKn?=
 =?us-ascii?Q?xqej1TtH+O0zQVTiaunOvG89LqIg6AW1ooDwEbT2EgCrcgkIjn8I3NsLDiLS?=
 =?us-ascii?Q?gFY93HzbgrNkNfkvMkOldmG4mZrLQCAHy7Rg044yZy+lRQbynz+SMv7FtU1E?=
 =?us-ascii?Q?ERyWsm0NBi4tZx3CngSYdx1yZuX0AHWAs1D5B7MRdixx1zth25DPvL4tTcaU?=
 =?us-ascii?Q?Gu0hzdlKOb+ptFYlm6h32B1PCDDZhgsrnPqFevsmjvcXFOGVvoUzci8rxDz7?=
 =?us-ascii?Q?JTq6sHfnvLgRC9j6lU3dpg9kjmBCIDaZHxQb5SzTxkJ/Gi3EQXcUYYUp/Poz?=
 =?us-ascii?Q?GSVl9eSDSixAj4qgxwHxjtyUnAsrmMwGWBVuYhO7bA4W74BeKXR6fWAoXqDu?=
 =?us-ascii?Q?+IQumG93u4Sd601OrLrkn/Pfw9mUNuirGGssL0hfB2+5tvatRgES31JLSGlT?=
 =?us-ascii?Q?wIMEtsZdTIP0FTYdvVTF8fWvdGUgMwylDT763gqDYULH3mQxlQ4dOwgEO1Dr?=
 =?us-ascii?Q?6EEQQ/smWIZVL6VbX1gej97745f1CpIyo6AOBg0aUyPV6HtvyeGqFXk5UuEx?=
 =?us-ascii?Q?QuG1Zs8DW/uVe2+9/xaNWnHhm3uXlMuhL27js2Xqc+xHTMOBoVPCoXLPAHBO?=
 =?us-ascii?Q?U6gyndtb2FTOTv0hT63W5+3P0sqMkbr9ahFCS+poL66EpaLIqgp27VIRgBWM?=
 =?us-ascii?Q?HozWZpbp0uPJy/T9v0oEzSBO7A+iKZdQH18802CVx6iB4ghFyRrapen6XT9H?=
 =?us-ascii?Q?Zzw7sY80uoInNiEUsktHIq+kiwW3YPvues2qp4D5+4GDhEN5qt0R8KZZGujY?=
 =?us-ascii?Q?T+APtJnh3i+o4ay4TkMqVODaMUAaOlnaidd+53Y9Op7oMolxWeo5Dn/DRspd?=
 =?us-ascii?Q?Wy5cgMEo+k/dqR7VZm5KOMnu1F5evc2uT7rB5rLUH17FVF4i3niLjgdyziVb?=
 =?us-ascii?Q?ioPu8RGZ9GQf/eUF8c8eKq1ImYlgzWZY1eqAiVEQqPrSZvScPKqU1Nir0qHS?=
 =?us-ascii?Q?mxhmFDw2t3mdhJ2lC3gu2s7F+MKBLnseuL0U/YCAbLwYsFZiYtMu7pduf/E8?=
 =?us-ascii?Q?SdS86yBBSsS2Hg9q0gZwGGjdevDPE1Bt+MatJqV5y+DCMEPcQBO5LO43ajqi?=
 =?us-ascii?Q?zFGbsguSCse6iwskXeEx/SM9Df8m7b4lZ0nDQ4A5XAQpUP5OF1iNhljggEPD?=
 =?us-ascii?Q?qJRSczLSGG4iz7p3LFshIgBzGVWBMV/4Dwd5gJ3yJLyoifYWiu6BSN0+jxjB?=
 =?us-ascii?Q?204NWz0iFAkZaO3+vdQvrWPSOjRKxze6wVthnWFXpIhP6D/TLb2Pc3JMsPZN?=
 =?us-ascii?Q?ekLZCypna1J5HR3e2XnR/O7GDB9dVldrQ6vCv7CZkNaihoI1gOCWZEfRBxnD?=
 =?us-ascii?Q?V0AW4rbtHxSQh1QWYt74ApiluJt7XEQqqJsrKJhiSn/WklEBT94KjQsPf56s?=
 =?us-ascii?Q?ItZGJ25lrKvkpZFyo0eD/BMEFq/xVeQkI/7weo4tuEtT5ZzcrFCK9VZ45sN4?=
 =?us-ascii?Q?Wi7jyBWpUHvGDbX6dvhMNwhvxWIp6/3XrD2IVsJT5vm07/r6LSrz/SMyzwcx?=
 =?us-ascii?Q?D0SH69APvReMEKOSln7fiHu2JPJrKNR9gYLCY5xg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb4a122-00ed-4c5f-24df-08dd313c63a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:39.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMcmMd+UXyHm+/TF7jdNNKJx4n9ksgHfx2s75jz62yfD4KubpO0S7HMowIec7M1IKtVz7W2HOzvcrBIUIBBh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:
 - Removed is_huge_zero_pud() as it's unlikely to ever be implemented.
 - Minor code clean-up suggested by David.
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 89 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 12 deletions(-)

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
index 120cd2c..256adc3 100644
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
@@ -1545,10 +1541,48 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
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
@@ -2146,7 +2180,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2634,12 +2669,23 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2647,6 +2693,10 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2654,7 +2704,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
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

