Return-Path: <linux-fsdevel+bounces-35524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05F9D578D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB5628317C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A791D5158;
	Fri, 22 Nov 2024 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BxOBJCTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1361C8FBA;
	Fri, 22 Nov 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239747; cv=fail; b=qtnbdXUr0BPQZAAeZk4ITjThuwc75d9nbitfCBRfyeCX9cx7hsbEVmwaBXkZkw4F3mQoEa3evo1To5Tf/huGovl2eNzSA/Hrd1ZqGcVLw1UeGWPLivgF2Fpv8u7vJm2/eDP+LmJP+/A2O3pfVhTlH1LTMQWFq0cfqjDJt9JERr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239747; c=relaxed/simple;
	bh=ARAYHn9uzeP/jw6NhBGh1r4J5w2mHxh6aAVuwkBESrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+Z/OteTPkSPLmrW1GMPWtZMa6m0HwmL29l5mDEI+iIBEf4W9FpknezgHJecf+kaxIJOOYC/6S7ZeoCj0bexI4pDlw3XC8tHmjv9gVgQthEVGAUQtbBze+9L7l6JD398aMPnFf25J5R2byEz2oPI/MYb11kKUHCrHUgptIKJz3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BxOBJCTV; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1+oLFGFVihX/esU17CZsGaIiYkiQ6f2FKdtcoTZmSaljmIocIfkbSipQKhPA/NdbO0m+CRedtue9lflIKcsgXcKhzIJHsGweOza3NAjodegkFFNPY7Ydy1daBkc+LzDQ06rPL7r6PQR76zb3PGCa4CQiTb+K3skbDO84E0DSFOmScQO5IOsLqwOkLwmhs3g9uYU3U/aKFCtmslfCmV1pSWUIinT1VZ9EIqGeh6QMku8yCAegTtc+IxzjD7uNNQ539UfTyA8vq8e2jz7D8eUQOmhM1i7xMYKniKWUdVIie9Gt/+AIdhi11KJKVg4FxWG3wsW7sPidb0KF3YJRVATyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsiANw4Jc50v9Ghy0wuZyrDvDVHKZeIEwRTiOOU3Uho=;
 b=Pfr4mSVD+inH6jZMuPi+ms7kkE3XiYlPMgiFIMXUD+8g7EimQps81gyQ0V5MeZifhQfRixzqRo+BdYVTwOgssqADnsycQEUVPb862bNYbsKa3dFCDBx7A4zM2LXqoA4MGP2k4KD73TLvf5WyZcD423xxnTW2VE6LzOGzIvXBh1xtnDewDB146pVEqGuVVQpqckVcmrLy1u3CJs24IqEkrN1lMV2m6ra9F3125Ht2AebWyGrq406eG9IKggcUF6F2IGBlWDmYrQ6U8NO0qmU/6GlHbiJfAmLMkstGKv83l+1Qgpcf8lTrxks/lJAjCBmAdmdmpoHJEoU5KRvfl06EQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsiANw4Jc50v9Ghy0wuZyrDvDVHKZeIEwRTiOOU3Uho=;
 b=BxOBJCTV4kV6Xl2aqVfevU0eBQYQD2YJr2heGPBjmTBSA0ScF+KITKjvlAxoz1l5hOgOZlvKlmkh1po5+chAtkN5x9LWstkP1cRfsSXn4vYsDU4/MbZsUSyvTEhQ+BvHY6xeybmGC8Nq1S2qQ5/puwbVMZDeqX0XrP2BT2mJUdEYrStFO4jH+tBi1PWlTOS+EwYZ7aZACRXy5OJMHzE9e2Tz0Bb1jRnRiMUQe8LpVSz9KweDa0LTy9juWqHqmW4Ad5O/rAJKzvYezdlu2DmUOrHPBa5KbRnBSONlX3LlUo3Lv2osiLyLTAAJYnimJKf6oiRqmQMO6O+hJPlO1Y8Taw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:42:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:22 +0000
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
Subject: [PATCH v3 15/25] huge_memory: Allow mappings of PMD sized pages
Date: Fri, 22 Nov 2024 12:40:36 +1100
Message-ID: <3792fee914ca7967b8e481f2e9d72c356f23d44d.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0008.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::7) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: ed696b0f-b825-48f8-dbfa-08dd0a96e895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C5IS1LyYdIRGLxXXfg16lkeo08KbY3/StuAKdzSqXQLCQPZStassz1xpxHc5?=
 =?us-ascii?Q?S8Wn18MaLG+OfUcR7WG0vP3LzUUjXwVPzufbM8tZqzlNPrr/L1G6GgULV1yt?=
 =?us-ascii?Q?cwdcIyP0WCPdYUCUuX+v0CUaFy30DZ2WaiilathoGmbACK61m6I30R6a73VR?=
 =?us-ascii?Q?ik0XSzbcnuGK3IWMBwompgMVSILrbdV7mEoelnlC/z7J647gWAo7uJHnCadV?=
 =?us-ascii?Q?OVcbwhTBcsEVQmzrf/74/0D+Sl/fRe0BvcElxqzDncrmeZcC2RZjFtvdStPC?=
 =?us-ascii?Q?+ATWlfdI51sMNOwO/LiNZjp+ZdIkc+xv+GMocHzVBMVmIhv3meig5/Pbiriv?=
 =?us-ascii?Q?+rM7OggU4p+ZnKfPkvneLBhh/80C0ltAbSq9X7RdgSUmkjzgzhAAkAVrVk42?=
 =?us-ascii?Q?lq5ivykE6RzU8Fj8cBU59Wz8izGyH4QpthP0RUBr56V3Ga0ylwDPQ804pkN3?=
 =?us-ascii?Q?hpKBvvz2Oqv04qXZiaOPImTRmLtOlJLpVCURF5r+euOvtLaMmTZbngNukTqe?=
 =?us-ascii?Q?pqeIqMZ8l5K4dgjVO7b96J3JEp475SmDMokDgD9CCYpJx7RPL2wal3W8TKuT?=
 =?us-ascii?Q?srfMBqfQJyzFfb758w/xpuzWt54rm/iIitYb0KNpwuxFcGJXwE1cgJr0lhlo?=
 =?us-ascii?Q?PtcS4wktGbWFt66mAePhix3+qG6rraXU9objpqJCHJFC4WqKFRtlrKHBok+J?=
 =?us-ascii?Q?urborcnZP5KLj4suvOn5xvLQQaER8+r+Kd5/rx83VUoOexsgIZ+9Qi7LPasa?=
 =?us-ascii?Q?ygKjrqQBJkIZ7xfyVWkrb90eLF7TDdXkesAvgSMxvv6lKj6g+FqSkEvZYel7?=
 =?us-ascii?Q?ufykyw/XxoIZDjl9euE+xNS0AWYCRbqqRM2myAn7OQwoOc2sYl6IAYVqhk7y?=
 =?us-ascii?Q?oEGWMOkTLwnc/yXed67e1JpvHJWJQDSmybMnKy/TLguLydnjI8Z3lo6wT6Vg?=
 =?us-ascii?Q?WCphhh9Q7lMACINlLg6/3CTPufH8YObY/wSrN9Da2KMTru/s51SKaDY8nEuF?=
 =?us-ascii?Q?HRb6vRJMy92JIXQW6cLqIXhzizDmAlhxqGjPw75gESBgdrBwAjbJSfr0uTzl?=
 =?us-ascii?Q?yB8hMK+qOuxZcxTTRFTxdrFn6a/cTLfjLwmAlC2vv5af75QnX2KBw8pfCt68?=
 =?us-ascii?Q?npo/RVtwBc+0dYwigRRlAGLPlxKFYRZdbwwHIoE5bqgiz3iHFvAnnYWhPMtK?=
 =?us-ascii?Q?BhJopslNfxSsrt8/j7mrkxiSTUdryBUfZOpVpzYimbz9f2p5iBCkg4Vtx1x4?=
 =?us-ascii?Q?c/UNWdo7HqtMEG8IphvKbb7OvFSOKykI0BVDqlyVOW8Ky6A7U1ULSaHkcvkc?=
 =?us-ascii?Q?9NrP7xhETCP72vTX1cphIhbC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHwQfpWVn4/uHLgtR8rohAFqTyd/lV7kapibaNxlfhUzcI1id7PRhA3btBfn?=
 =?us-ascii?Q?ga1Ey37KflkzjDejuHG1j2tsIRN3W+naeg+l1kL5XuWcv3PmAlg8KXDsom+g?=
 =?us-ascii?Q?9B0hnhL4+tIxMIxl+9VbeyHQRkT9UGdrwhE3x7HM6dLbsfOnn+GTJi0/Ojvy?=
 =?us-ascii?Q?3BYNCmw4HdKtjgjzMKtrLsvcIOw9tAZy7whgn1cDk/GeY2OCh7OEJBLfVjaf?=
 =?us-ascii?Q?SfzdZGrYStkxzoZ6wZ4xXMM6yTD8j5dZjgSBfxCkXqyZz1brXgXOVdCgzrUm?=
 =?us-ascii?Q?/UVygN9xVImr/43wOrtnBoCSfKRPzFqEPdT/Jbwlec55n1KUzOyRraxQWwpF?=
 =?us-ascii?Q?ILyEBHerP/YQRMg0uwezY1nJhiGPdzNdO/WiS+TXe5Ue76+NaLF0/80ukbE4?=
 =?us-ascii?Q?+F2g8lIRYWDFCMEiAF4/7Pk/Zual1sr7zpbwLJ7oIemvwOPGW7BptSbGK1d7?=
 =?us-ascii?Q?99fFWI7dH/H7WsSAEP0qlxL0r3/Al3uGEg5saPp1NNu9MZAoo0zAREDXIiRI?=
 =?us-ascii?Q?ckdYyYdsfdA0ykMHqHHdQy0T387DHPJMZ5mhwTr2w1lMbfkcMBFHRnzBQNP3?=
 =?us-ascii?Q?Lzy9JjkVGaP0zXE8O9QtGWgktu5FGs+95L9BPSGaqaxg+Fkn/1iU/cCuYI8W?=
 =?us-ascii?Q?EXRa0I+ovfTkD1wUb6E+7OyGEix4Xzu7eOA6DiZQm4+584jt8VrFJtXllmpw?=
 =?us-ascii?Q?NrKPc6UD2A4MO3O+SELeRxVxN41x3zpaJg50SWStoS87phvw837fXelPnNEo?=
 =?us-ascii?Q?BZq1P/gFG+LHggfKf07+cv0G3Cml91R4xuFlVngB6Wptsj5RwnHGPDWmLG8f?=
 =?us-ascii?Q?V8Uwc99CgDcDfbWRZob8vFzIO7MBG7BrWj/wZP0vhSvifoyPQIKEaeX4X4m1?=
 =?us-ascii?Q?xDn/7ogbnLTaYc5HK4ebT2bnynw/IrCZGG3hJosVGBAsQjYaKCoEvAKSXZg1?=
 =?us-ascii?Q?suV+i6LHxup7kYbaEXOGLPZsd2oTDAVg9dOgvX9jsO3QQF/EYFsOLw8rWyIN?=
 =?us-ascii?Q?dL06gbFlUF7ndb5VG5i0hN6vYZ6UQ1BpycvVVugOczHTR3gkj6CkHxkWu2Ow?=
 =?us-ascii?Q?WVeoBHGy4L+S0lFPLirqHyE6v+eGfX13uBuovv3CgIF0oo9AEvQyfwJNI0my?=
 =?us-ascii?Q?AXa4hCqgohHJIrUPXidtynNT0cqFIKhDMaCEzIdXTJcsT91KnJIJ08BS5Rls?=
 =?us-ascii?Q?pDXjphl4LGzEQx96KyDr08+yiktOk18qH0JQGrmByFYPJV/Wmxtb15JZrozr?=
 =?us-ascii?Q?J8Y0vh/6ucLXTiL6Ou0GKVomejy/wmZKoCRWtf+d3kdHlWQ/pFvK7De2jN1v?=
 =?us-ascii?Q?zMryC3R42fRMsh6zk/FaCmYz5hVIs5JN55Jgb5n1vZqJ18dRTbpZ02RDGpeo?=
 =?us-ascii?Q?zF3AgfnJvAew/sk8GavX+5YsrGK81onBB87mbkAemBiB3DrJu12ptqMvCoai?=
 =?us-ascii?Q?6+b2ByRYE21+/ARXHPA4uhl5Q+LiWra8l2KAYwpqWp5pLuUk2YQ6lWKQa5nf?=
 =?us-ascii?Q?Z55pz3f7uN114pO1QnVdfX34gy5EQJUfcPghuabm4mhsTKeeB9rQ7W+uqaQ1?=
 =?us-ascii?Q?mtlsbOHzsfMZIeR8qYDxTRrntxSlB8wDsCtjeHVr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed696b0f-b825-48f8-dbfa-08dd0a96e895
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:22.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDhvDGtTdkTg8Xc3dA5GWv8FB/SsIgyfVi6wl7YldZ+KyRCV3eW+sa1kQc1CaFbMp6CDFkuItOwApBlCtuylpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce vmf_insert_folio_pmd. This will map the entire PMD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
simply inserts a special devmap PMD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 60 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e804e41..120d0ac 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -40,6 +40,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
 enum transparent_hugepage_flag {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c51ef3e..b3bf909 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1340,14 +1340,12 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
-	spinlock_t *ptl;
 
-	ptl = pmd_lock(mm, pmd);
 	if (!pmd_none(*pmd)) {
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				goto out_unlock;
+				return;
 			}
 			entry = pmd_mkyoung(*pmd);
 			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -1355,7 +1353,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 				update_mmu_cache_pmd(vma, addr, pmd);
 		}
 
-		goto out_unlock;
+		return;
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
@@ -1376,11 +1374,6 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
-
-out_unlock:
-	spin_unlock(ptl);
-	if (pgtable)
-		pte_free(mm, pgtable);
 }
 
 /**
@@ -1399,6 +1392,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
 	pgtable_t pgtable = NULL;
+	spinlock_t *ptl;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1421,12 +1415,58 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	}
 
 	track_pfn_insert(vma, &pgprot, pfn);
-
+	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(vma->vm_mm, pgtable);
+
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
+vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PMD_MASK;
+	pfn_t pfn = pfn_to_pfn_t(folio_pfn(folio));
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	pgtable_t pgtable = NULL;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
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
+	ptl = pmd_lock(mm, vmf->pmd);
+	if (pmd_none(*vmf->pmd)) {
+		page = pfn_t_to_page(pfn);
+		folio = page_folio(page);
+		folio_get(folio);
+		folio_add_file_rmap_pmd(folio, page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
+	}
+	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, vma->vm_page_prot,
+		write, pgtable);
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-- 
git-series 0.9.1

