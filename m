Return-Path: <linux-fsdevel+bounces-35523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADD9D5786
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D222830ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B11CFEB5;
	Fri, 22 Nov 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RIk91l6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFD1C7B8D;
	Fri, 22 Nov 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239743; cv=fail; b=Lfvnz5yRJj6X5uy8DVfovEjryUZn7EqH5Olyi3pZJCn6j+yeoOjRQGBueTZUkChjf5kBEEHhTB74fHj0lF4s9wcObgQ9RW/oNDWnXDXfM5rpps9MmjtiYDb8Bwer16evDvc5mU9xTQKmcH8OLH82Wlhew/8dGbhrUUS7OsLvQx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239743; c=relaxed/simple;
	bh=iYbq+15QowbWNA0FAmnS6DWJSly6bWTzJuzgjL/9rSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6y/HV/SyPKnQXQHAAy/+h6ma/eHOJkHuwgBbWyS3V4PY2dJMJ1tT93nxA9srl/l9U6btUO5bOqbYAIn/5SXl0KndfxwChs1oHMtgF1rQKRo16bJjHHTEuxunAaF/sN5iZmnCWQEZtkIzro7wTkcK04igWIzcPVDs8kCoy0a2Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RIk91l6p; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEcOHywHW1iyH/flLPPGlboZd1C4EN3p3UAujN20S/iuP9z9V3WPQQJhfjhuqpVLAotXOl7j79hmLmT9nZDwZVKmBFMbE+oAboRhKaq9AwKo6l1mYtWi9+3bAc/7EQyA2UepVVfr7oIJJ43GqxQk92aw6N7DLXTcudgHG+4j7xnVQdbE5/u7QJyfCG9Xy83Hl1CC1C5ePRyA8rS0ztJKrBl0DMcFOe39GoElSo17z10q8B73BM4/eJT5pj2D7leMirNpFCkiuPIBVQl0OKFxOICK/V9pJsgtTqxzOhLEB4w2PVZ26RnIj0FZcdRTxJuwaJaxet8NWtSSxE7Baw3M4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNNDrZGYjuWsY6LGZ+vu93m4DKb6QIsZnqMbyiKmB6k=;
 b=T6D2YBBz3F7/It+2uny8+i84BJecYT/8+MANPQ+masLy1YKBc2RehuZiIBfoJeVTL9n9M1vA9fkusdUw5EbIbGCGg0jmV/q+RH8+/rXYpAKsMpdT7YdizyL5Gby19s+Z2pc9dYVp8eJ+BeKTipmK0OMqweStcBs2PNmMkzCKbJAq0y6mkxyE6MMf0Nb21NMT5rfsK6z4q+Ju2iq69xMGbN6V5g22VS3KuicPDa5aQ+ESEHnxx4mu3a3fBI1YVlUHkqv9EGjAAj4MOmI1LZq2tNT/lXYyhQcnNl/xnzqXZSAvxOx85/2qVgFP6uqfbpzKH/kZSk5NoldlUXZTyCBepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNNDrZGYjuWsY6LGZ+vu93m4DKb6QIsZnqMbyiKmB6k=;
 b=RIk91l6placjmqMXs2PnUlPJuNM6gFvlgiLwz+9IzO/6AF2RX6B5h5FsHNQUHlOxtpRJ6smYkK1av1V6wI8aX1FTMJ+GKFr/gxLtN2OuMFYZibwvC6ZoJK3cqcJPcuuycIlayT1PdYWm/03JU0XomkuxRgutqOax5md2sWx+5n7ZkuaSFof0E1cWxai3uvzJDK7wvCi/eVytYLldI+LxoJp9DZ68bELzlF8IJISNbL8FzyS7hSLRxhkl75+rz921hsrGUeM0/+wqnpqhXuM2B42P+hc5XsyUaJjutaWE11r769ctik70p9sMT1Yqa6H4UwqeEwIxGpD/TJ69wNJayg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:42:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:17 +0000
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
	david@fromorbit.com
Subject: [PATCH v3 14/25] huge_memory: Allow mappings of PUD sized pages
Date: Fri, 22 Nov 2024 12:40:35 +1100
Message-ID: <dd86249dee026991b1a996a8ab551b1b1fdd32a4.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0013.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::12) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: d187fabb-62ce-4285-9190-08dd0a96e5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIxNCHcpauAtobSq2NOaU/Hl3jGS/wnfV3N24Hy8n3TrBWp8L1HWHIx6yn+g?=
 =?us-ascii?Q?fBUcxF3/vC3Bm6QFtYjKae//CCyVCnKkonNkYtH6Ii4dLQfcuiWlibrx4wKD?=
 =?us-ascii?Q?mPU6jB3wWLJA7zJhMqAxkEgXlbsHkT8+W8lQnMJP0f/K2iO8pqcPrDgLEO/N?=
 =?us-ascii?Q?nkTfNMbUFHsXasgcFkZE715vlK5dhAFuPqkoegeFGcO5vQmJ63ySAU7/eclC?=
 =?us-ascii?Q?qIVF3qMpUt2ZDB7MJBjC6shY5VOxtlXNgZJvRfkar5NMY4SNNDT7rn9/eIBx?=
 =?us-ascii?Q?TeiAREQqBWnNdAxOcptg9vlUtQ/YAStv+dC9qYzPYv54qFFe2j18mZFnRISh?=
 =?us-ascii?Q?Blwbfns4h6HBS7y/Z9q2a54TEnuKTKC2r7M542wLt9jJp4Z295KHmvN/ky4x?=
 =?us-ascii?Q?FiHyYnusBFyozOu3zPkJsncZzedwYTfkH/ZiwKpu4b9ZE0SICg8KHaFJp9Nv?=
 =?us-ascii?Q?nQly82XNHbIwrSfS2EFN31+NrKzZDjuUCOREkld11u92/rA0zaaWEsCCMrVO?=
 =?us-ascii?Q?T3bcq2SiRWPzqFs2gL2nJMVbuXJXkLeTgVq/fqACjHntUWfYidNT1vcDAV4n?=
 =?us-ascii?Q?Ui/MUx6WzNw0cH0zfBO98ha2Vt/RN1gkwP3UhzixBsh8CHSRUde6BDAzSiDq?=
 =?us-ascii?Q?X01EcXhjbIW0M5y7qXkSpEVvE1T1YBohixSWEVct0wJObsStOP7shFuVGR5g?=
 =?us-ascii?Q?nykuLUF5PYbAeCqLI41tUo6UpvHTK+fD3W5PUuojG3uThMqWS3kexVWYb7Xv?=
 =?us-ascii?Q?gzqT1QS55mN0d7WzUuEZ6sLJBYMVBJd3nBKlpecb6KfvEJLdPjm1viM0FoW3?=
 =?us-ascii?Q?lKrRw7n6OalZNJab057Y9qTVp4BCAlwi9rSxFUBQJ5XcRrdo0aFTmDPQ4RTc?=
 =?us-ascii?Q?YQr3PZ9Yw2TjfDOGa3C/hgT0c5izUQQhutgVj99vrZfmaW2Uye+6HboRSO9/?=
 =?us-ascii?Q?QN+cj8aCTDh+IcJs4wKEShf7sci1Aorx4i39U3OyxhwrHX6nSqsF4GEDUx5s?=
 =?us-ascii?Q?LmdfRqrTo/n/5UgMZyODHpRN21Zrehp34u5m+7o0dmlVOiCR7KY7DnIooQm+?=
 =?us-ascii?Q?YLxhKO6dfHucBvNoVOvhaxLZ8S76pH954T1P7vwCqROuIsEcSaePOtDf/tU/?=
 =?us-ascii?Q?V+jRqFuQRzoe7rFokWcUhfI2VTSesgkqej1CemvmljJQ/EGH6CMZSZ1YIv5M?=
 =?us-ascii?Q?Z4VtQlz3fXaNg6zZ5wBu2/pxNTLG08Qi9hSUCm0cCcNaG6MLFhE8ybH9Ekua?=
 =?us-ascii?Q?o45uor4Sy/ArS22AvLKekFOsGimHlnNdObk1SyzFecU4X7U5wMdRkajqtxdc?=
 =?us-ascii?Q?QYCEbQcVz4BLECJXqFN+FuOB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEQPSyyrPtr2Aaoonp400ocTCOUkegG72KpRGQDiy7HH0iJqRhZf5Dqz5RS4?=
 =?us-ascii?Q?QGoKvwWE7yoAKNuHwxEwqDxusJXwiyHzSzBjPGpjgblTeOj4ptzmgUJQp9ke?=
 =?us-ascii?Q?HnBUDoe6o5xPx5O40ECdoMrZ8ovC2vh8RZDfoHD1XYf5WwA94PmUefuiUyCK?=
 =?us-ascii?Q?GVuhcE7O3DnmcqGOr+vo+cFaOFv7VCxOeYt9jcitXUAEutyuJFTPSXGXjHRg?=
 =?us-ascii?Q?fUN9a3DvRs6wWFnfBuDZKrqlu3W5PanKl28YRXM0iLL/829nVlbUoOGw6f3f?=
 =?us-ascii?Q?IfbU7uHaFEOTtxPNgtUrXXp8Et21nctWM/XXSPvOEJIVcAlWzeTFGTA/NMXZ?=
 =?us-ascii?Q?GB2F6xp6MKuoI5bRy5asNV7Ki+GFB6248ERlj/+QaldiK0NkNaCIN3afnnyt?=
 =?us-ascii?Q?J4GK+kCwkxdPPgJtEfXKe5mzoVkWwBAkDjUXF5M9jRwn6fkIzEIws4fLAIN3?=
 =?us-ascii?Q?biNM3RDP4pyUoFA1WeM6mpWBxDCxjDCQ1c8Ikg3JcaHGcdpjEQIL3tD+LAOO?=
 =?us-ascii?Q?4IEEO4Unx1oEmB5jhBALvnPM6b3qYb4uVPwoyeX2xKRJrQffc7r4Kupt4+01?=
 =?us-ascii?Q?tYTGvhWPB4C2dhCWqRW2p5X7f3cNRKwn0eFK90c4BuNDuEJOoYO0/yF2TOwo?=
 =?us-ascii?Q?jUtkVTDq/KN4Yd0K3SkQWpHy3P+1cr+RfIqxfOMAx4paO3sfWOu62vtAAFR9?=
 =?us-ascii?Q?eCI1OJ+TrJP2VVBOE1FgiMLIfeW18dGnfVZi7ZWGiOgZS22MrCwulxs9Lh+t?=
 =?us-ascii?Q?p42/Pmuovxcjmhm0JUSxTQL8bWsO8Nc6OidtZPiFhcW49ANrnabeGL2PndQM?=
 =?us-ascii?Q?0A0NQq12DqsuKVOWQelfRpTJeGkCcfaYOKhK3eY05jY1IBji4zLruI8gtOeK?=
 =?us-ascii?Q?rXX5E0p9tDlpbgxP6y6tgWWsoT7LAdhSWE2WqatmKuCGd/kXMPglB7jiCFsk?=
 =?us-ascii?Q?VcccyT0nRJGVL8B3vpPKkwFCtjOP95pPAjBWSlTk+jUqGannftPVWGDJk985?=
 =?us-ascii?Q?BQY8l+JLAnNg8AORMkfc9Oak4zOgjnSJ+Ltv43O6aElk+Jlh2rySD+p/Ro7a?=
 =?us-ascii?Q?FWj/cYFb9Glg4KSZjStTZGko41wGC8lTxdS23UY2AWvUbQBkM1wdp2oBC7jY?=
 =?us-ascii?Q?V1hb4SMOitbxIRwPCNkFzLy1ryMprikYBdVJJ8AuYwaXQ2DRDjFHzb82c0yJ?=
 =?us-ascii?Q?6eQsjUun/kCk6dNNebAlT/ECUDdYa90AzwQxkj69JbgmK4HUCaXE6Jsm4j72?=
 =?us-ascii?Q?Cw4px/vaMKdilNfAkTNUNT75CcUBRJJggQkLGmJf05P0wb66GKB6UWGp5WQ+?=
 =?us-ascii?Q?FeW0vdMBF4VGkY+fN7yhHqKaAMgG2FpPv3Z2kHsql9C/hNOMzaPrvTeZHHFd?=
 =?us-ascii?Q?ZoY8QDZiFrBlxWmq1i5lnl7ocFAz1owJlLA4KPn+aofoAgyEkAoOp2IaEMC2?=
 =?us-ascii?Q?AVW5Y+JaAtrpICMHdhQimSzbu5ZF887icVbhzoSs2IX6XgNtm2l8v+mIP6av?=
 =?us-ascii?Q?hzSnBADG/QXSJOidnVnORbWb5BMaT2UfAztt8fwk9ZK7lFbuIUytBHHKdiKw?=
 =?us-ascii?Q?3eGb1wnIeyILFM+r03dx9bWgfxsWEWINgIJy02gG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d187fabb-62ce-4285-9190-08dd0a96e5c7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:17.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UdrdtaWFgD5dZRgAv+FNpK5jy7StFgvuVfE0nq9mteNnrZObmeyLxK4KklWIzReCoEqZ//BHA6jr8NRiKAMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h | 11 +++++-
 include/linux/rmap.h    | 15 +++++++-
 mm/huge_memory.c        | 96 ++++++++++++++++++++++++++++++++++++------
 mm/rmap.c               | 49 +++++++++++++++++++++-
 4 files changed, 159 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ef5b80e..e804e41 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -40,6 +40,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
@@ -468,6 +469,11 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
+static inline bool is_huge_zero_pud(pud_t pud)
+{
+	return false;
+}
+
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
@@ -614,6 +620,11 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return false;
 }
 
+static inline bool is_huge_zero_pud(pud_t pud)
+{
+	return false;
+}
+
 static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
 {
 	return;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index d5e93e4..4a811c5 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Asume that we are creating * a single "entire" mapping of the
+		 * folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_add_file_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
@@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fb3288..c51ef3e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1441,19 +1441,17 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
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
@@ -1467,9 +1465,6 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
-
-out_unlock:
-	spin_unlock(ptl);
 }
 
 /**
@@ -1487,6 +1482,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1504,10 +1500,55 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
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
+ * @pfn: pfn of the page to insert
+ * @write: whether it's a write fault
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PUD_MASK;
+	pfn_t pfn = pfn_to_pfn_t(folio_pfn(folio));
+	pud_t *pud = vmf->pud;
+	pgprot_t prot = vma->vm_page_prot;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &prot, pfn);
+
+	ptl = pud_lock(mm, pud);
+	if (pud_none(*vmf->pud)) {
+		page = pfn_t_to_page(pfn);
+		folio = page_folio(page);
+		folio_get(folio);
+		folio_add_file_rmap_pud(folio, page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
+	}
+	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
+	spin_unlock(ptl);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -2066,7 +2107,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2554,12 +2596,24 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
+		BUG_ON(vma_is_anonymous(vma) || !pud_present(orig_pud));
+
+		page = pud_page(orig_pud);
+		folio = page_folio(page);
+		folio_remove_rmap_pud(folio, page, vma);
+		VM_BUG_ON_PAGE(!PageHead(page), page);
+		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
+
+		spin_unlock(ptl);
+		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
 	}
 	return 1;
 }
@@ -2567,6 +2621,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	pud_t old_pud;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2574,7 +2630,23 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	count_vm_event(THP_SPLIT_PUD);
 
-	pudp_huge_clear_flush(vma, haddr, pud);
+	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
+	if (is_huge_zero_pud(old_pud))
+		return;
+
+	if (vma_is_dax(vma)) {
+		struct page *page = pud_page(old_pud);
+		struct folio *folio = page_folio(page);
+
+		if (!folio_test_dirty(folio) && pud_dirty(old_pud))
+			folio_mark_dirty(folio);
+		if (!folio_test_referenced(folio) && pud_young(old_pud))
+			folio_set_referenced(folio);
+		folio_remove_rmap_pud(folio, page, vma);
+		folio_put(folio);
+		add_mm_counter(vma->vm_mm, mm_counter_file(folio),
+			-HPAGE_PUD_NR);
+	}
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
diff --git a/mm/rmap.c b/mm/rmap.c
index a8797d1..84d7ab7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1180,6 +1180,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
@@ -1330,6 +1331,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous
+			 * PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1523,6 +1531,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1552,6 +1580,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
@@ -1632,6 +1661,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
git-series 0.9.1

