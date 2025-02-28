Return-Path: <linux-fsdevel+bounces-42818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8FA48F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544C316F5C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8F81DBB19;
	Fri, 28 Feb 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YC9TMgfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32AD1D90B9;
	Fri, 28 Feb 2025 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713559; cv=fail; b=AKXefBVIN8EuZvLJW6SaGY5U632jOPN+VFLnmYyAZVRFkcj7yxZbOS96oyYBBwQYoUHuwnMpV4/LvF3QvkCcPzbwaFSUW+53zNBpkhKkG56YTvxVCB6BhL6bbJtm20o+hYqhxWSVPRjnzucoxL4+T3rgiHPHdGwqC+YHi64Wk0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713559; c=relaxed/simple;
	bh=HElqc8tt/n6B8c+Viza8GhSX/qc7WHba9YrIKdTbiqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oucb3zcyNxOZLLFrkNqT4d3P6gXZ87VI+FsIi46EGcvEbmWhs5CfoomDTZjAsRAjutxTZOGkzHfDwyTbuErw94olb8y2pvuEIlMyBrv6M4Z2nC9KmWyP6QbmHWopLQxDNtjIFcRQ9rLZnwMHg8hxNjvlTEe+A06iMEp0q2G3JAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YC9TMgfX; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/RbGRmYP2oUJycSSYAnUixa8yrDBUACn8DvSSZ5NYe61igx7QqN0cReObOu2vj5nha41pckFBFWFm/kpZi9CQAzLSg7Kc8f5FTRLQUAUglOSJuACXkzjWajMzGIi6leY9qgOk39Jf/B/fpSMqPvsxy9VDwFsjD/ojlLz0Joyy9SgpHyrt7Z66X0LRNsoFU+G93HiYqIrJv5K10zonIBQwn7esNu+YDmhWW7WTbinH5uHbjD0rFsQPwq4LLFgh9CyltJR5Wx+2BQqm6Rl+YtcSLaWKnqGsKuMStRemgih4+Z0/w5KyIVeyUw7zHIxlqIXiEln8j9F5pn+cK744r5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqzD7sEFSC4LaRKIRiHCWZ4+XsjlEZSCqu5EnQeyOr0=;
 b=StjCyGL7pXBfG/QJbtyKTm/ao8wcP7vZg9eAmEkv5K9EqmpxMUDK1V6991hwQeRN0yemtSu8I/Pus8mnWQrpky9sarHONuIraVhTKw6oPsGpBjcdp7hJPj8bdQDJUishEzw9rKOqeJSmydhtLIq/qzrq6BmZRdQmYQOA+BzU7DGFI0o76/TNKxUq3q/Nr5aLqshiBVjcIlT652XUwAKOi5/R3zfGfhpRoh6Qh+coknudQd/+Kq8sRncJ8YMObuqcmbzK0O2R+FQs+fnDf8So3MVzY+N2vPDcQwgtJPhH+YmraiIhXHFALXncoQmHv6/glqewZbJF3BEfy4+kWUylzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqzD7sEFSC4LaRKIRiHCWZ4+XsjlEZSCqu5EnQeyOr0=;
 b=YC9TMgfXwvvEYHYORK36SdOdqBnkMSUB+S9w/my+0XSTPcaYn0pDomYWEbxKfS4DO6xhMqhyfjZ7IA3wEHye1HEsmrOjHcVIqePQUCcndkGKvO/Y+Usz06ei46WeT8BN9MmkvX4zTcmjORXK0BJxaQBtrTu9JETv/C/TATj5+Ok97pTaVqy3rhp0EQrk/uf46Aa9+fXVQL025S8zvZFrrc9hPuz3hP5QFxShY8Q+0qNupsqoGVaUA0Ukmzy6YkuEwOODDNXSuVEPviZq/w2oFKSreLUS1DziuaHwGq0+aLtj1Y6J97siVXTZydqYuvYc5oLzSA6J9QNqoflC3I7ZbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:34 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:34 +0000
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
Subject: [PATCH v9 15/20] mm/huge_memory: Add vmf_insert_folio_pud()
Date: Fri, 28 Feb 2025 14:31:10 +1100
Message-ID: <649a1ef91d556593948351e94f51ef73a14f6794.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:10:110::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcbde85-6452-49a8-2193-08dd57a88a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aw57hOUoB3XnUGz7yMAGWb1+0qd1OLt17xv48LogYELvGT4LE5BR8IgO5XKy?=
 =?us-ascii?Q?edgXG8YZzOY2RsaL/Oltu8SfY4hcxQktlhpHNfgz4Qu/QM/TdSk3MW037fZE?=
 =?us-ascii?Q?LoHZpFrh/KdMqiTPIkljGvc3RFuvrV8J+1fAdH110fWmS2k9V8KgC/H7WIe5?=
 =?us-ascii?Q?H3xGwaJzLJiS8QyFM4Leyfq+aeQkSFw5FC3ObERNg5BcPH+KMNxKmRvkoHf7?=
 =?us-ascii?Q?efZhhLJb9XOrE3YNUKMXt4dx/V5EDiGRoNkyu4Y42YojT1mQCrFvLtrh5VDF?=
 =?us-ascii?Q?Pi7il1bHGjS4CkepwYslUbsdK/txtcIXTPNl0+WLbyte6bx4hLpAsSauoeTd?=
 =?us-ascii?Q?nWlty4kFKw6efMTt2Uh0c4b+CfX7cenwkuVk7+9VhGYp9rJeTYzckyJ/ihRP?=
 =?us-ascii?Q?+u2V2c4OaBWdJRxMu6/YQPIS5H6anUUoGhl4z1TKW/weWveUw8O/KNf912tv?=
 =?us-ascii?Q?ssv4mb277gW2kLJKppOOKp3c5kAznd8Uue0YmDEjVdLqTWIf3mUsQVPAeItt?=
 =?us-ascii?Q?p36JFxKHs/Q7myn5RmtGN5kdF1a9yAcuw8Idri88JH1cQpVW4qSkOCsDazAE?=
 =?us-ascii?Q?+knJ2Vm/Q2r50JtbmOlgfqETvQQWxe2sdgPVlZGarGP/kU+tyYSgPRFT92fi?=
 =?us-ascii?Q?xQ4vdGB/KIj5hM+XrBdWtkUancMl+JTFewiyH9lByDoHmgM1ZhfxgcLp8YiO?=
 =?us-ascii?Q?MkPTtsjxDRwaqZvtHZfsJvtPN8nTGzRy9ioHDF10qNG8RomDkhCsGtjYr6Ml?=
 =?us-ascii?Q?8P40VHEbjFBZW7hIEXUTRYK975Ex+wmnhj9DEGyRh10qgKC1pByCQuSyQFCW?=
 =?us-ascii?Q?sN/lTWxjqYom1b1mKuXOVa/LfPqoJEsDK/a6T9lEJ8F5ten/O8VXOdTm4lmA?=
 =?us-ascii?Q?8+06/MHsXs1tlKUIZ0kmHARUsltvNFR6dthhWI11w9lhjnKi2iTQZ3AcJF1Q?=
 =?us-ascii?Q?1s9rnweq8Ut5K4tZhiqxdbk6acE9IymdotDktRcY1FgLA+GG7VBewaL0j7mg?=
 =?us-ascii?Q?1s+dAKaPb3HUtjzg2eMzwXGSeLLMz8lEjZPaY39bEHiaJrh60Xh3HsFtS2un?=
 =?us-ascii?Q?rOC8IrstmgpzeVUmum7UVy22thKjN/Luo+r/bClxk44zH1RehTxv36H4iphd?=
 =?us-ascii?Q?ekfLPftq1C2XHnegiBdvWHdoCac6fN4sEbW5lEnqTqH36uljh3pG7+EvR47e?=
 =?us-ascii?Q?6ElMDpSPvFX+B/xmq6MPYQ2XCqbu+XoLBHNJ9uzduFRPxL2mBP7NZFu9ZBS+?=
 =?us-ascii?Q?PYr6WEDkFHAbQeeIYflM5tnio4FzvjjFSBUXqpI/C9GXu7dd1tuepv02Uk55?=
 =?us-ascii?Q?n6aomEqGnp5EJQkK45qoqH9hZjQA1demWnZsaZWlI+sjGD2IjmclP/0mnZ/Z?=
 =?us-ascii?Q?s9r+PFsk7lDEEAFLjjLHKcNKKnNv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mt9saix1+Z4vsLXCHe62ZNmYqVUyawRke7YY/Z6vGDz3VeY5W7p68FVOmXzX?=
 =?us-ascii?Q?fNZZBYF2UTw4I17BlAt3Ketdi4Svt4hxXBil1XwmpWsrBQJ2SzgUhUsu8eEM?=
 =?us-ascii?Q?H9EsIa/nFisCeevA5UZgHF7c/OOHkdQTnVng78iUFxOhqGhpmH0z9fivWgaP?=
 =?us-ascii?Q?RL2s83pVScaWWdk9SJle+1ILyshPPqtLFYbCqP0RshrCOzBHVmQbuB3U7/U+?=
 =?us-ascii?Q?jGgnlgaQmPpJlf6qaOxG8R/rUxza46l6z3W1Fl7M8rcv6FZJni6rWDLH7gcF?=
 =?us-ascii?Q?nIe3/zdopmyX/CngWOC63pCZ8lmkPZlMSb5xsgPs5tpdpIpk9wqtzSDnBJyn?=
 =?us-ascii?Q?B/MfZwbYvVID3DhYjAPT+SSzdX+Px6DQzHvYqV1TAZbGntOnfY9OFoC4epkF?=
 =?us-ascii?Q?vlgv2eLkLpFulc47U42+TalctBeoXq+aEtDODAPtUlU1erRqQ5nHnZAmgrUD?=
 =?us-ascii?Q?s17A2V3A1dH8bPpMBFpiInHik0/B+tMWbe4OAXUnM6kWC6zEl3oGC1Q5IMyy?=
 =?us-ascii?Q?yWvq8LjfPIGuorcykQOldQJRiv1yp+0/onkNu1mJZK/Z+9sIBjOotPH0fsJv?=
 =?us-ascii?Q?SVJIBQ/BZJkV9BDIMq3TR8yiDXcp6CpvfwK+XObS6yu4cl5feR3mhiuz/xD5?=
 =?us-ascii?Q?DQ25kzz85CsHkgUGSee5V1hyyJUUKfThCamMh/QMdKebjO7/TXOxHikypLab?=
 =?us-ascii?Q?87Sn7ynq1XCE+RDArlhuVgaiQ6fF6Q2DbHojyPvHHNfDRmezcrYMqID8PlNX?=
 =?us-ascii?Q?QZvcocycNf2vpXSGkwboTDG26DEyoeGu6aylBqCFIITYkAaWTDaKPlInmfWv?=
 =?us-ascii?Q?rpex2D+xy/PLlrrYGjo9WMUHzxTNTetCiFEMGFj+Sr4xdKzkUA7StpZ11yBC?=
 =?us-ascii?Q?QD5ufDNTXvL/Lhu2CJ+2qoBXTvoAGU35IxNvZm/QNrmPBaJL5rlo5gK/iNTj?=
 =?us-ascii?Q?jWNbI+9Y9JtC4kIXvd7O/jOIrdho5laOgvPDIL0QnRpax9pNeuJdQxgyjKlk?=
 =?us-ascii?Q?/MWedlCAkk3eZyY2YmlrPdpUIybcfBz4Ol+Wnkzvjb/RaOuwlrCo7jlYQqro?=
 =?us-ascii?Q?nEUZAybGRWb67UP+dtzov9CfevlY0swA6993YJnJoWfZTbh0amz4Xdzinpkz?=
 =?us-ascii?Q?V5XYS/2JuJoK1u1q3LuXkyVoO4mMUpT5BnaEmrN5lYAdtdh7kF+dmpwMkaou?=
 =?us-ascii?Q?MsMMvVc2+XIMCL2kdGh+AgFcjJnd6R5ndIS0jZK86nisKvtzLJJey9GmqZpn?=
 =?us-ascii?Q?3XJnat//zH+ZiUhLYhIAiPZ0DN7rmRFX+05ZYj/KoanNwNJr2GeErlUOsFNj?=
 =?us-ascii?Q?kpm+ikI5SXvrpwIOZkUDl8mI2rR+gr25czJoxEMoMlQsFLo/yYQVuc3QVF6h?=
 =?us-ascii?Q?kdlFCs+2uv/S0fS+WKPmS23eTdm3YhZrCbKjzIlZEPcLIG2P881xzTQJBGqs?=
 =?us-ascii?Q?xm6q/FxMDZ16QGrOl/ne657Blmv3o/TMUIAQZ2jMB+YoHxDH8DFil/6gKbIw?=
 =?us-ascii?Q?RFUUw6GTH3dMnZQTWj7Qu4uRs2S1OgOFvuRBBj5OYuLgADQHhXSzzM8QXBRX?=
 =?us-ascii?Q?IyKIGhsFL6ektMkZx193G6gaiok+lPuk/vcHB8ax?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcbde85-6452-49a8-2193-08dd57a88a20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:34.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esEgplQ1/Wgu+5NrSWpyLtAOpKalIwvL5aLhxdXFBdlrdoVMYb/MKs6zaNI1hsrxZ7zd915Ds+NIfpuOYt7Zgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v7:
 - Added a comment clarifying why we can insert without a reference.

Changes for v5:
 - Removed is_huge_zero_pud() as it's unlikely to ever be implemented.
 - Minor code clean-up suggested by David.
---
 include/linux/huge_mm.h |   2 +-
 mm/huge_memory.c        |  99 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2bd1811..b60e2d4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
+				bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3159ae0..1da6047 100644
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
@@ -1545,10 +1541,57 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
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
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
+				bool write)
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
+	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
+		write);
+	spin_unlock(ptl);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -2146,7 +2189,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2646,12 +2690,24 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
+		VM_WARN_ON_ONCE(vma_is_anonymous(vma) ||
+				!pud_present(orig_pud));
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
@@ -2659,6 +2715,10 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2666,7 +2726,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
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

