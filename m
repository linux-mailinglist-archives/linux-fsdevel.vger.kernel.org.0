Return-Path: <linux-fsdevel+bounces-28978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62A972812
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B16B234AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBF18D649;
	Tue, 10 Sep 2024 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+tZEiAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E918EFF1;
	Tue, 10 Sep 2024 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941730; cv=fail; b=tHlMoi7w/u7/g+Z/fJ0R5cBNc4I2X44AgVSV2KsEaTz7P8WRnASfSDMGDyTQtETwCiu6far5HaqNySF7fQ2mJaGD+rDsaBwInlCQjS8ku2hcmX3m9GsI3aQNkGnQQjiqW/FDQZhImsnpal5vVtNc0BsLD9KxrF82znbLw08PlIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941730; c=relaxed/simple;
	bh=ppN7AeQ535KjELJTEfxCfPobSJA90d14ZG8egdvqiEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScDFU+8AMmJZuxvc67KpbgyglRWck8aJE+dujpHIT7EJa1ggkQmqtewMSITFJuERG1FFn2zWnhDOpPmqYTcJGJh5KZWzPgJLwTrqGX3zXgu8dLXnFzCWggHgG6N2NntURz2CQyK2jbrZPZwq5KncylKT93i8A5B2GW2jLX71Irs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+tZEiAz; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+ZOssOVvz/rCwzeZHQ+U+uSHxq+lSEhcTcLXlFeBMgB5xmln6jLVmvk6gN8Sxu3fGljVMU9SgNATYMKe4xGYBTkNXAVLbPdQ2HYbhNRYovMRSliIkqlbKGbXvqSrmR8TWY/nUrert8KhMQPXZS7BnPJ3UeIhIVeJP7CX/QyM+uDqcTUnkvSNYEW9qK/Neoa4Q57Kr0Zg9Iy3hcLCiJIndZNTcgA2kY1nr2ZKZXzQVR1GjBDKcQ9wWu9H0/ytcP+KyzARpwUYuRXSQaejqM45P/I7kbjDcFBcJcpainAx2hZJEwgaLnD2hIrHjpCz118yCHqiRNgd9CGNoO3h0zAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bud1BOoIKrruKCTNC42zk12SQVHnS3DekPle0TBxIs=;
 b=uaRpCH7eE19YvM7Ok/2mao0rNEaVjvkDFnn8dqhyjdxlXiLd02pn7nqi6Q3/+RSx6LzQdcGtqKekmtrBG5fsK/n5QsG8+/SzCu2xu5w4U+oiJGfT2KepU6fU4HwWOdFcOrL7xscoR4MDNKlCJbWPZzvaLE0dGzob+BPPdySgQmdevr23knGoPBPaOEaN3yttmQ7Oo7gNOoh/5P7HpGmmHi6fUieOuYx7OnJun9sS72rQsN8RYL/WZ3Bd6A+zHBhal/TlwxpY7b7hz2jpqyjQTyDMzAOY2hzDlqD2IJyAsPSr+5f6BheqmdbLRHPx4yLKnX1FvsHOLx+kKS8MV1XhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bud1BOoIKrruKCTNC42zk12SQVHnS3DekPle0TBxIs=;
 b=c+tZEiAzjiLklX/B6fYH1x9f72oqj7xzPw8IYgdctTqzMSGm1me1F6er+CtYrn7Nd3KM+a3v5duYav2DaR4Re+jvD4Z6jsWKgeLRJPcVoiEWjDvWrlY+32ZafUBrCbKElkZBFD8YE1R2Qz4oX7IaEXQq8igDfW1122avvfxZINr1da1LvLXXLlmlQz9qX3zefPsjJdnV12KoIO+w8F8S5sI/jj5DFR8OrDgehgl/8HwBVSTZhF1kWHHJbHG3L+ycwN5Edp4WMA/RLm2cEKCt/vf+HYHNiEe5jpPLcOVzrCQz/SWOzcabfBb091rARlyfD7zOzxiYEexXldFZiKUvaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:15:24 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:24 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH 06/12] huge_memory: Allow mappings of PUD sized pages
Date: Tue, 10 Sep 2024 14:14:31 +1000
Message-ID: <3ce22c7c8f00cb62e68efa5be24137173a97d23c.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0038.ausprd01.prod.outlook.com (2603:10c6:1:1::26)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: e252b8ee-a36a-4332-0db6-08dcd14f3189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8FLTFF1tbGPHDHObo9x3BBrfgQo0kcQ7btnVJnhqjc7/m3A5yePlGwc2rEZ9?=
 =?us-ascii?Q?aHYERs61AZrby39RJWG93aZIxXbP0YQvFpXC9ecx+1Bsw/y+GJDEQc16ryp3?=
 =?us-ascii?Q?Yvvo61j01Qvg4hjIZmEt3Xb0Tqaf1zw4WQ6j216vHEfawUbB1PEU9U9iONKV?=
 =?us-ascii?Q?Pzj/0DRjOVCoWVKD2fzlrxgsDjSOMVay77Eec2SmSiG78s5+W0nMXzRXGv6k?=
 =?us-ascii?Q?VC4/DwBY6b/q9yXhXpRRM5cKZHZe9gfTXiKgbFFV0EQEIYR4C7dp/di60lWS?=
 =?us-ascii?Q?FtYgYDO/6xI9xwJzIyYDgUkPayMWCDvYq3gWOLaitGyH8g52dwiMPLfqstQQ?=
 =?us-ascii?Q?Z9d52r+XiLLFmvO+HYoWBOcR+TG/h6SMOkkNwuK3FJoHHnQM3xsftPkJ8A5M?=
 =?us-ascii?Q?SCZLQaEwCBHKYChxnFVtlyh4e3xj+BGWOcXtpeXBwy023eo+yh6O9s/fLq24?=
 =?us-ascii?Q?3vGj7H0Of85nfcQB1crzyl0QjoKRjucXMBqKSrNHKjGqcPCEUM/8yLO7jtWo?=
 =?us-ascii?Q?XbRpnz2q5iSSRO11Ew4mmrwzPoxpHqwhX/kCiYNRuwfsvlvI8eBXLrW/nNGK?=
 =?us-ascii?Q?kqPTy/iKkbLDJyulfuFQHnIcGezzSnxsaQ1nkqI23k0Ek6t19kw8fs14y1m4?=
 =?us-ascii?Q?5yomrUH5ju8ROCsZU832JDevfe/MLLfIzUj5JciVPTYHBFb1ABGkqFg/5X4C?=
 =?us-ascii?Q?QXFgtXpwNPIjqfa6am8pJo5H0amUEPCIThrSxC+al1SVm5Lk0Msy7ugWo8P5?=
 =?us-ascii?Q?u1s+Yur7xRbo0wfyRVT8BWdox/Iyp9qHcPxfjVWVCM+loaud1jA1W2+NW3If?=
 =?us-ascii?Q?iLBEphrBjuld/qiyzN74PDRWHiD0SSAnNEfF8gh8BLZ//3sJky4de3IWrQVg?=
 =?us-ascii?Q?IHly0mAB7bIbI2jX5Mr9JvK9pKTZByVhP2FGarIGeabtHrgI0OX3GBpkP323?=
 =?us-ascii?Q?GZrTyYQED+FasdwD8VEW12cB89yed6v7Fe5Mjn77ppp8yWDasxkV0xFGJzM5?=
 =?us-ascii?Q?+H3D0dZQgZKcIQK27vX+RxVLkuVuHPZLdGj2joIAqSoa+l0bWMeJPoSenO/U?=
 =?us-ascii?Q?29xgBmb4JKpRRatVi8mp9AxjnTkWejZRctvDkWpwaA3v3DpWVWi9SVg8ivQr?=
 =?us-ascii?Q?F2DiuyLrE98XO8uR3GobuEZaMiuqZjODaNz3i7v0gBk3f6o0eeCxRpiQ5Vzl?=
 =?us-ascii?Q?WIaaI9o65a7VQo1h+Oiw2lz7+OPHuqbordZPfGhBNSfAJq4OpAg1DGpHdSA4?=
 =?us-ascii?Q?OzgR/cXIWhFCqr/5beOUiSW/0lpyKPxysgRw38AofSrQA0slxVaWzLTnXn8m?=
 =?us-ascii?Q?hESa05EaIGUcNAtVdx7ODjaoV8JWOXQB/WrsRxrhgnerog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O6fAvEy50brguwa6iwu+iZg/Q160isc+uCr2WwThmEWKZ3ThvzTyqK7JuDdC?=
 =?us-ascii?Q?h43H8Jcw9tgeldm/NZO7xHtBG/jJaMqqHZFb88OqhscuGQACw7zfBFLIrznL?=
 =?us-ascii?Q?E0uvBYbe6OC5csAGfyeBdJ8UMXWFVDn8mNfvkAlQEEyTJOcBqU0dA20iP8C1?=
 =?us-ascii?Q?/mJ8iaU8hGGZ3DJWVm9wbNG6XFTieYCe+lA20/T3tULHdEM8/fDoK1W4dYIT?=
 =?us-ascii?Q?oLF/+UYPrnVJcmPRK4wKGZEayE/9AkpvRfhdS+GzGjBfKqFX+kRSF21J+R1o?=
 =?us-ascii?Q?na5/OMZWqjJAih0KfrKiSIGgGzQxuyMF8ln2MIJRy7pfJ2itZf2g/xhntSVZ?=
 =?us-ascii?Q?SsqP8aN/N+0X3A4JVsJ8Bw7T7h0luCZGQAPCMjrqU6iFCtY3vjkTGn0C+2L6?=
 =?us-ascii?Q?YR2jnsF7w6OWhb8FJwjMgq7S08ymIqf3moqKSCle9/L8ffAVLX90kKnP57WK?=
 =?us-ascii?Q?F+KX3UoTnUYWniHxVWLzPTP5vIpF/qaT66tA9lz/a+vtlA2jkUm3Lo5rpaiv?=
 =?us-ascii?Q?J3ebpJ5fWBkHNWZQsx4D+mSwWO3a/DpBrgmlu8KGfNwYlXbzYejwtqskn19I?=
 =?us-ascii?Q?mdgrNBMN4Gh0PkzYgrmtOnwKDOXjDTffJ5gEhbztwSqQw2AOh9I+VD3ZNxCG?=
 =?us-ascii?Q?7tISzTMxFAQDdxMNP8qEQ5/ClltPwfuUwm+faL+uDp5cDfumwhQD3W9SBx0i?=
 =?us-ascii?Q?muUQ1QDpul7RbzLvhdklNLLNyD5mmMd/I5tHorqdZQvz3Vuoi/uOtSZB3A/T?=
 =?us-ascii?Q?Op1RoweBonN+IHAsMO4pVsii1ELp4v3TO1GxuGvQe/bDQqjzwUquKbbHK4cf?=
 =?us-ascii?Q?eO5OI4hwOmuka0GngdcXxfGO5caGN7Hrc3XxszPuKsOIXjVNS9tWVt35Z/CB?=
 =?us-ascii?Q?w/bC0bfTMuFMdo8JeAMAcBb6p88DMkzoY1OKO81uox6QmqN5HaSr2YA8jxJo?=
 =?us-ascii?Q?QYzUF0x9vNxHHJTsdZgW4c6f33tr8qtZZy+gyx0hbRva3YWOu2d+p05sAdfK?=
 =?us-ascii?Q?TeN9M6KYzPtqKDXxPsKkeHxx2jkXCdce0svRKSeFpmerNRw263/3hGnQ5Uos?=
 =?us-ascii?Q?lvxzDGB18PtGaJqBYIfDs+lTVjhJ8ef5vQSGmBY8DchtEY70OljKO5N2If/t?=
 =?us-ascii?Q?JPKMQhBuytB8hdPtVgdvgu+S6YjsQegbayN77foeLz4Y4OgAuACzNZME/Wq/?=
 =?us-ascii?Q?LUAA8p6QI4w/GXm+mRdkrk3Gu1YbNjBPGL0qciLcJQT6Um2x1kC/IxPyEcdK?=
 =?us-ascii?Q?baoOQzRDDwAXv2JQEXH/KaPTk60LsXYVUvCB+hxzcjXsSTKC+HGUMQb7aVJn?=
 =?us-ascii?Q?rWxiIaRAtcU+gyvV5sIZMTCqmkMlp1ZZ1sjwZZcJXK5pLORP58jL0Ojf3sed?=
 =?us-ascii?Q?BfaBprF8GyUArO80WYI7znKjP5T962KlI+7tUA+uAYNnomou/j7//eo4ljRg?=
 =?us-ascii?Q?Hapf69fDLEijAoJCZ9G+0N+Cxh5aYvD8af650rGflL0TutmV2sOB5jJr7+IM?=
 =?us-ascii?Q?pSZaKuKimdSbu+AfEJU4GoZt0jUrSGr/91XRafqOj3QwymtB/R/vZOYHmneg?=
 =?us-ascii?Q?AeOR7gP1OWBvVZXqJA+EHmVtqeiAeORikr3s827p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e252b8ee-a36a-4332-0db6-08dcd14f3189
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:24.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49ZJzoWF5ufNXqH4Cm0oPh90Eols0q5j5pF+TRPU7EQHNP4NqLmT5ez1M2NT5gSSsCLAd+aKKzzwbhaisvSJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |  4 ++-
 include/linux/rmap.h    | 15 +++++++-
 mm/huge_memory.c        | 93 ++++++++++++++++++++++++++++++++++++------
 mm/rmap.c               | 49 ++++++++++++++++++++++-
 4 files changed, 149 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6370026..d3a1872 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -40,6 +40,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
@@ -114,6 +115,9 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 91b5935..c465694 100644
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
index c4b45ad..e8985a4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1336,21 +1336,19 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
-	spinlock_t *ptl;
 
-	ptl = pud_lock(mm, pud);
 	if (!pud_none(*pud)) {
 		if (write) {
 			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
 				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
-				goto out_unlock;
+				return;
 			}
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
 				update_mmu_cache_pud(vma, addr, pud);
 		}
-		goto out_unlock;
+		return;
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
@@ -1362,9 +1360,6 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
-
-out_unlock:
-	spin_unlock(ptl);
 }
 
 /**
@@ -1382,6 +1377,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1399,10 +1395,52 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
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
+ * dax_insert_pfn_pud - insert a pud size pfn backed by a normal page
+ * @vmf: Structure describing the fault
+ * @pfn: pfn of the page to insert
+ * @write: whether it's a write fault
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PUD_MASK;
+	pud_t *pud = vmf->pud;
+	pgprot_t prot = vma->vm_page_prot;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
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
+EXPORT_SYMBOL_GPL(dax_insert_pfn_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -1947,7 +1985,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2435,12 +2474,24 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2448,6 +2499,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	pud_t old_pud;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2455,7 +2508,23 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
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
index 1103a53..274641c 100644
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
@@ -1522,6 +1530,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
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
@@ -1551,6 +1579,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
@@ -1630,6 +1659,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
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

