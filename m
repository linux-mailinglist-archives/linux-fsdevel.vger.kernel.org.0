Return-Path: <linux-fsdevel+bounces-42038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2644A3B0A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEDE1890DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70491C1F05;
	Wed, 19 Feb 2025 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epCT/TD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F31C07F6;
	Wed, 19 Feb 2025 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941549; cv=fail; b=MLDHRxtjXU0jGItdRFUSVMyUebjfY5WFUKW3vFJMezJsq00iHVq4gpO7zIZa1DN33dLegTCpoK9CsDROUdJ+UPdlratiWz25xZSTA5TX+0udcd3BNNcRID4pAPf88Oq/50U2gDdGZCEV71Tf7MzP3qDjbu86JHbVu+TBye7cv2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941549; c=relaxed/simple;
	bh=rPA5S00EOKBWLD1PCFLiSimIf2UzNwJtGVtbCRWk5io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URVzSDU9ulp3M5cbrllBGlHwvx/Zzz5fw7GkQs5zp2X/zZ5ZSlLglhsgTnYA23O2qibgrWbguXqvCKHKCn8sbd0k8Ymr1AfusrFGjMAVI/CsA0e2xyl4PGg9HX0Wz4JZt3ubUxVBqzFC4RHtIJtIT1hkYSmXPaC0YoTmz/0ubQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epCT/TD7; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VReVlRkeUgsGayqO7K/Pfa6voME02u1mFDdKZI6epNHz0iEgzDF2QlLRTa2u+cFFqKkhEMNT0dsoCsvGebzhwrlUl0JjOwYJL8pcXZ0miXt9IIJWFVrlQfZWS9NL1kIrkwmL/Gk8gygfCL69RH9gMTA1Dk+CAD4Klj6Fkygw8YM0jWFpzI8oeXW17De9rQgyJY03DI+D40dMAsHKrodSA8v2Vuu4Fq/ZxKUsiCsPL3ll8+nR3OmT8eAJqW9srVpFQQlJgwqIrWfHze/F5VWCEoziJ1YhpDJ8SH+gNhpgmOXJR90c/Hpb9MuElcrhW3dudtm8QyLuIFd6kFW+kl9YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jObJa/rMZSPU+8Wdjomf0Tvi4esknf7mPa9topDk5IA=;
 b=au95sRy471JM6kd0z23k8RN+pGRqkKLdsozdPP3ITwtYdAiZE1ERcMbfqGzKc03F7/dxI5LlW1UBkN00j7u2z8Rcz0U3Bv5/wqYkg70EqLR8HhocStplLHU8NoaRCAZPkRqqL07yHrW5ggG1/3fIjxypyBEwj/XIZURCNx6VOLecQ7DMrbtvswt3Bd1ETkycqlH4V/GBGEWymZFu47KNvGKn/M80ZLhugKlo/F//P4BmrZuEHpwZUpDLCP1Z4RiMnw1DNsBJeuWF/prhbqzreJzIhqvW+SIo5pRSRrxjDfIfD8rFoi8CN0heAvrXIN6/XEB8MmxP3KARrseVY3Gazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jObJa/rMZSPU+8Wdjomf0Tvi4esknf7mPa9topDk5IA=;
 b=epCT/TD7xAxYaM0zWGZXNDhAiajsR2auWHMEsdSDhGs1ZnbNX+ie3i6gxnqJ49vowD/6/nHaNKURRb5Ev+wH7LPlSvyKKuEpKRokbpDOyOVJ8f6bLwBF8b51nQku0baCQK1/aolDM878Ntj1P8G0Lvw+iuYXYn0BP0eoHrDTZbsxYn2ma2LpnmYNKwNlOqcu/W43HSRUSujKkQPUXWb9CydNeW+E1wwLmECFGHXX2QyNuvF7V7i4/ozenMlbv73aNUfP2k8hNomcWZbOL7zhLEXj0nQWT9zBw0odMMY1YUXqrQTOtg1eWzY+LSCoYp9ugDatdno5P2GR0Mx0Gchcyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:44 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:44 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 06/12] mm/gup: Remove pXX_devmap usage from get_user_pages()
Date: Wed, 19 Feb 2025 16:04:50 +1100
Message-ID: <cc97392ebb7f749de3ea9a2aa0a68fb3c59c781c.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0155.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae25c3-1f30-415a-dc76-08dd50a3105f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYBxxw5aVd3SDRk0k0k9wrtTB/Fmy33eKn2FSH3rmk8szPqrZJ18KJBm0+xU?=
 =?us-ascii?Q?crcL+xIKJGCKWlRNF+rWMFDpHIo2p8c275qEKa4vOXYl5dAYhrGUUrObMIWq?=
 =?us-ascii?Q?J9O48Xwt8Nq6228w2Wkb+3TW93y53MU7lkpNus3ow7s8E81tKn0m2p+j1/QD?=
 =?us-ascii?Q?FpX74bhE2c/VWhsRcSdOQHidVo2CKJ5sFTqH+CYY5cNozi79beHH0MoGIvOw?=
 =?us-ascii?Q?cSbLw/79LuQnk0Ustm1/IAPqYwtVpaXFGWQqTr5T7doIpVk8FgVwC+aez5zE?=
 =?us-ascii?Q?SzZ/NtMQ+vo6M/94Z8MTJ4m4hJMJnTQC86i7vxEW8LArwFsyaykqXI+rmAdA?=
 =?us-ascii?Q?rXME95z+4ZDptpBe8P/V96ftXt9BrnPkCfwl8mzSOQU7GSRChKlJ3U5KM0Hw?=
 =?us-ascii?Q?R1WUJ/oPY2teEl8UOOnycUBC2E57fEYv8LvhdAKK0gvpNEvxjYduTjTFOZC+?=
 =?us-ascii?Q?C36gSuQSVYD1boQ3mOdKFxr1SWAJUETBnSetp9qpjXHXx5FyQjBtv9FdUdNC?=
 =?us-ascii?Q?sc1JfjhyrpbV2acv7qprJ6R+kbq0LH6GzHT7Gcu2i2PXcGuSYq4qqjLvWe4j?=
 =?us-ascii?Q?iMrTV/eRBbeEtpOCMGwoqEWIX7HdRG+klCcamEZz1rjrRaTVc+ryzY8uOMVE?=
 =?us-ascii?Q?fsqNCTNWtK8tI/BI1NW7IlXZU9A7ylzYTK3qobzMkkjr1cEF5EwDwAL11y8L?=
 =?us-ascii?Q?VnrJnP1WbEQ6Esu8tDLpBQ5rAQTGsHxsa0qX88Fijz7sMylB8xZ/GhYRIpiH?=
 =?us-ascii?Q?/1V30Qx+Qp7SF7/8+SVVFFEyD9X8H04et68R8TKwjSX+r6CxU6oTnLDZcUu9?=
 =?us-ascii?Q?KLL4bHcvbTe9snnLQ/Fq73v0WexhtNqJT4myRwGcNALfF3Pi8KdxOHQdFgzN?=
 =?us-ascii?Q?AQbHnnZgiVzVrwwGNx1wniLpq9WTkL7g9u59+p7GG2+lZXhSh0bghOSCI36e?=
 =?us-ascii?Q?NcfVdwTvakOL/NF8ABGoUYpdiljJnJpTp+HaZNHa4VGKyAH0rAhMZZc3JPJm?=
 =?us-ascii?Q?u54d4ageWxPk98sQzDO4L6SPgJtptfwk/hbH9REUywmCq9q037GFbzVeg1mv?=
 =?us-ascii?Q?Mr3gkrFM5BRKrkp/Oj8wH1hwTVD+4U1DsHu9Js/0r+NuBSFPOv7CEmDQIF7Y?=
 =?us-ascii?Q?pchaL0YTqNGCpKSxEufPU61k9AA7vJtfabfOUas70PdkXyRe/fCOqoa8sxg5?=
 =?us-ascii?Q?jaNWJB870CqlQ8IsqVono1YruX2aAujjdMVUreIqC631vsd09LwJRfJecqfT?=
 =?us-ascii?Q?v758YSH9nU408yfLpYDnuOPf1brYOCzko2rRKKoKBi5at6BI2Yc6KXBqOSVQ?=
 =?us-ascii?Q?t/dgZbNefbgMOjpFk8T0/AhRCyJCE0e/95cHDKWTub8zbhcQ9NwJO37zV5cq?=
 =?us-ascii?Q?MZS3PDzBtiq2Bhd18jB8X9yaMTBF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9MCGwlAHRKRCV3IFhqe28EbfAH1WSNXI3eSZxrhMKCwW89vkPFd5kCRrZv+?=
 =?us-ascii?Q?lI0UTFXR17kaJKKNXeiOlW8q2HwzEoXJ0VbeRlPGY4ZnI3IMkeBX2OjbLioG?=
 =?us-ascii?Q?Vi8oUkD1Sm8M9TUsx8Dee24EkKXXg6wHdlnif5dV5nXOnc5m4lsDdIGry/T7?=
 =?us-ascii?Q?2ikKyQefgoRIHG0hz1yD9NohjlvlwkYDOrq5e0MuXu/eeHgtaNmFibMJboja?=
 =?us-ascii?Q?jU4E5lOYrWq/0aMSXgopeAqZ+QqUXEF3zU8cNNrpLiXdOiz2h/gXDok3U/C1?=
 =?us-ascii?Q?AEqN9rH7gQ1Z60vAzq4V95w5Kg/ltueZ17185EQI6l+sz+5cAqlchYXlr7Pm?=
 =?us-ascii?Q?DFu7jOHmcSYm8bKenb2h38U8wISThMNrlIRqG8M0JGRHTiIAjVu0POjfoSzm?=
 =?us-ascii?Q?gaOypjH9xANwnwMCdf9dzWXeNsKs6KW+iEiqdPFF5yro7ZX2iGarp59MXUI1?=
 =?us-ascii?Q?ROMd6tl2mjRhqzrh6Kkh46IHYelRMbVjF8LAvl2ir2SSpdFq/6puRCDa25ut?=
 =?us-ascii?Q?s5k2BsZEtUqlVRGgwf6gOCpNQH6u3Sh5n4GuAV0y99RX7OPfkzFR6TDQUlxx?=
 =?us-ascii?Q?TCfoOypL5yqsD4JwKXk+6zTMKfNybuQzuzhYMVGKMBckix56CHlxIPOIY9MW?=
 =?us-ascii?Q?EiUh/92eQD9Wt27J4HNuDm8J1Bwv6WpuDWw5mAy6CCLwi+wyWjEkP71A6JNl?=
 =?us-ascii?Q?Sys09lOTrHU+tsOm/2rxdVZWi0wAtXxF+YrX05bVGRMvuVR61J6OcAu8bqgu?=
 =?us-ascii?Q?mCwL1QJupbpe1xcvov50QDpVu1O12BGxK8Z5xOg0nQo9uRRBfkjDiBLC8AO7?=
 =?us-ascii?Q?Qg7Cay42/t7CDbfVysFKcQpVC7vGwrljFvBAKuZmOzd573RiEVTyfF8jf+39?=
 =?us-ascii?Q?jEoWMIofwUcwRUIVAoyWIhafuKOUTQnngQQm7p4Haf3sXRvJj+vUv7Z0ENsC?=
 =?us-ascii?Q?LjSCdd6wHF7X0IlP9hm8z2CSeHiTV8djeNhvw6+F93at6JbgA9SCvOHSzDZ1?=
 =?us-ascii?Q?BBhTajgX3HFnMP+PmT6lqz/IoIxoS+jEzEWyDr5P8Nbrk+wywRwGrDd8LWTV?=
 =?us-ascii?Q?knDcy9c32e/5P2MMZKoa/ZmDmWqeuNOrUl/mQs1mvjlPb1Y5eH1U2uQNbx/b?=
 =?us-ascii?Q?uWWgR3nuGrIiun8U2bK1lReFa+ViPLlk+Pcmuf9JFVHm9kpsg6iu5YuXi9BV?=
 =?us-ascii?Q?D4nGtBYdJAOWGdpa3UfNIz8sblmOkcQnrfvRNPDjN6ESXsvgsSa4l0RO0Pui?=
 =?us-ascii?Q?sE58KTLY5bLgvsAeDh8u0sWBpnNoKNQz5BLS2Qd1/jTIzGMhqxEpGuhCWxG6?=
 =?us-ascii?Q?bneayNwshSrw4RSaFH7zkxL3Gi/ogcHbrWiNyLCwPQsklJ96/l7sGxb17iGh?=
 =?us-ascii?Q?IW/8NLlQLg9jER3oFn6Hrh3gxV3X2zBjJSJGAr1cJQLLAKlm8kGfEekhaFkY?=
 =?us-ascii?Q?kOfW6MwRAxxl3dzwAfy2WQsoefnCBJcJovfs8F5DCOhwvRm0+gtWP1SIF56+?=
 =?us-ascii?Q?6QAZ4SipFZoB/mmZ9MQULhuLDsDP7YeyWjfFibU0dIxDFKMgpXRw9Jv+FLAe?=
 =?us-ascii?Q?QDSVjpC9GYZ3Rdd2ke0UJbCdcBU7YokreytQxOC5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae25c3-1f30-415a-dc76-08dd50a3105f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:44.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCtp2IgjKlPb3EA56ZODnVCE4nTuWRpBvfs9Y0IRDkRL82UiRcm/7dxRxLKTAjytTSYqmlkHXhiDSXVuwSadog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

GUP uses pXX_devmap() calls to see if it needs to a get a reference on
the associated pgmap data structure to ensure the pages won't go
away. However it's a driver responsibility to ensure that if pages are
mapped (ie. discoverable by GUP) that they are not offlined or removed
from the memmap so there is no need to hold a reference on the pgmap
data structure to ensure this.

Furthermore mappings with PFN_DEV are no longer created, hence this
effectively dead code anyway so can be removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |   3 +-
 mm/gup.c                | 162 +----------------------------------------
 mm/huge_memory.c        |  40 +----------
 3 files changed, 5 insertions(+), 200 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e57e811..22bc207 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -444,9 +444,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
diff --git a/mm/gup.c b/mm/gup.c
index e504065..18dfb27 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -678,31 +678,9 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 		return NULL;
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
-	    pud_devmap(pud)) {
-		/*
-		 * device mapped pages can only be returned if the caller
-		 * will manage the page reference count.
-		 *
-		 * At least one of FOLL_GET | FOLL_PIN must be set, so
-		 * assert that here:
-		 */
-		if (!(flags & (FOLL_GET | FOLL_PIN)))
-			return ERR_PTR(-EEXIST);
-
-		if (flags & FOLL_TOUCH)
-			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
-
-		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
-		if (!ctx->pgmap)
-			return ERR_PTR(-EFAULT);
-	}
-
 	page = pfn_to_page(pfn);
 
-	if (!pud_devmap(pud) && !pud_write(pud) &&
-	    gup_must_unshare(vma, flags, page))
+	if (!pud_write(pud) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	ret = try_grab_folio(page_folio(page), 1, flags);
@@ -861,8 +839,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -870,18 +847,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
-		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
-		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
-	} else if (unlikely(!page)) {
+	if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
 			page = ERR_PTR(-EFAULT);
@@ -963,14 +929,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-		return no_page_table(vma, flags, address);
-	}
 	if (likely(!pmd_leaf(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -2889,7 +2847,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2913,16 +2871,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2993,91 +2942,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
-	unsigned long end, unsigned int flags, struct page **pages, int *nr)
-{
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
-	do {
-		struct folio *folio;
-		struct page *page = pfn_to_page(pfn);
-
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
-		folio = try_grab_folio_fast(page, 1, flags);
-		if (!folio) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-		folio_set_referenced(folio);
-		pages[*nr] = page;
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	put_dev_pagemap(pgmap);
-	return addr == end;
-}
-
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-#else
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif
-
 static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
@@ -3092,13 +2956,6 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_special(orig))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
@@ -3139,13 +2996,6 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_special(orig))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
@@ -3184,8 +3034,6 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 468e8ea..a87f7a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1648,46 +1648,6 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	ret = try_grab_folio(page_folio(page), 1, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
-- 
git-series 0.9.1

