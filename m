Return-Path: <linux-fsdevel+bounces-16635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515CF8A0507
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0767E285AE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC680DF5C;
	Thu, 11 Apr 2024 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzNiGa63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56566C8C7;
	Thu, 11 Apr 2024 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797084; cv=fail; b=aNz+u0ZUJZ1PFXcHpSxidCELOR1bI9kbOoLELCy/bNhVGJkSFqrNcsBgW/rcfw51A1He8lcLQoZm1fAeVMd6OTbL7Y0HwK08QaLpRTTMawo9yf9Z8FUIFrvpi2Q7O0QGhaBK3cI62OKBdNwQj4W9VR4lVBrJN1xrBIX51wrgjz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797084; c=relaxed/simple;
	bh=7Asb6uW0jZEW1qBIs1IecFGTcRcFBk/nnOIHLc6uUKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIomeAH2H6SyKWjK1H2uWYh2HytHTFrgYN8A9h+mBSMRz2GpaHwd1eOj0YOIRENsRW46SfcetU88gw4iWQqvhzDDJaUO4CsQ6nc0w4dRywoOSpi3Kviak/n2+Yw7ukNvgNyopvbD6MbqMt8boIdPQq9tR9x0c9rVH4n2EdhMyoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzNiGa63; arc=fail smtp.client-ip=40.107.223.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOiePBco8RHKwptwg5HfjAU1e/PTpjUTcxk9y4NWAbC/fNT6X5s4tn3GoVyYip0TEKHUsSA0l4H38weC+ntcXG5hZhrjKtZTZrNkB1Q7dvMyERRwBaFzbL4vnKZ+TLDvyWH0eUSmPc9fkB8kTgK5IFnQoVUhPA8pruq/HG8UdeqkA+jaaO9ttx+0gk0qFv4Xmglmn2QiY2OplFwuj2EZNwN/NMCoX08TMkRZiww7sCMx0kllpeUdbJMfV1oINKH3ENI+IoXTySLcEsbrk+65HxaKkKJP28YjXtkTC4dByoWWFWSwIbpxJeffo/m094I2bMihbfTu2Yii8aYiLhj0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/EFNZYda3h5NnSqsdMPpS+So1trQ4UQ0pW75JDKrRo=;
 b=itPoZBhfXbNt5unBmFh1eQ+hf/3oZgUlylpXeF6jjpFnSj4MkpjJpJgGOg53omRZWVopFDmRm9m7itLHHbZIzNWcxgC8il87tvxaa609Qiji5Etiejpd1S36wBlycZar+vEAB1hW92kuO85OhlXzgNL1QdkgxxXtRgZvWifXSY4oqZMtaBHvl98dxAZHmQ+fPYmn6abrIR+yFqDbq4hW/41+pSJudXxMnh4JHX2Np6ym7tr6V7jQva9uqrOtEV160MxPPODptaPqTnsthwM22p3rCH3jIj+emCvYEds/R2HBRXYKAbXj9uCgCmJaBUK+AyRmMDio4iWuxpP/ZQHzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/EFNZYda3h5NnSqsdMPpS+So1trQ4UQ0pW75JDKrRo=;
 b=nzNiGa63gF+2I+6JXTx9oKd657LsHdgtfzgq/S6q3oohRv3UQzNx+mHZbaGrDyyz+VtuAcOYOjT0DeDC3M0S4X2ypjuJA2fed9V3FwdVwPpVKXg6G+J1YSyy0iJOZ4JBHaYPLYVH0gtRsaqlq+aVDEI5gKpe0nmr8o+A4+fP42eeqNMSvgrrazSi1q4WKu3dshzj9/YCCIjlLvvbxVGAqQEQMTXQiWsiIyShkDAe88XiGhROkB/cEBUApAflPBKig7mAN3jhuIa7znLNsQI/xjDMWzwRKfrHWF8uc05A+RSrAIFT4kiklNg6v+R7c4eP1Tf3c1KyOSl3w8pZZQuEnw==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:57:59 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:57:59 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: david@fromorbit.com,
	dan.j.williams@intel.com,
	jhubbard@nvidia.com,
	rcampbell@nvidia.com,
	willy@infradead.org,
	jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	hch@lst.de,
	david@redhat.com,
	ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jglisse@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [RFC 04/10] fs/dax: Don't track page mapping/index
Date: Thu, 11 Apr 2024 10:57:25 +1000
Message-ID: <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:10:1::30) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/czrOa4Fy11p/on0hAzjxlD2XX+k71O4cFiRszZxxk+97vWp6hHXdYn1vUE8FhcvncJ345huDmL8uyzSpjRPjbQ+z6do+B/1oysh8gFIb1l1eCpWfxugcUA/fGoEVy2OaTrdbhoXOJ0C7yK+VfzbOMDRACFtQBM0olsSIwuC4juiV5J26vjpAhzdXYgc2ejqEL8u1FA+VXTBmU44X35J3FEcKgEcBMm1T67dQkxM033hcZdEy5gDNcbySUvTo3eUNvUkINJ+j4AOt51Q3YiKI2hD97fOmzWmB+aLu2tMBTc8AcsoiOIQmPkJFQt2sXqmkBB08M06jZsvoVi5UgF2n601eto53x+5gX7mvD7JEqbq3I1qTe3U8FVW7X4tERfR59q4KR8ntgfajuvGP6lIubmDg9RuN+SQeMMR+6wZ0jR8mo6C3PKVJQT2rvT90RKuVvdg3d38I36iRR/iB985K7O1jLM+8ALPOPOwE7btmc2zuYz+qvZEOnLgkTvPtSR6sOody2RE9BKlc1yvYMqWcFFxfNDeiZ7K+pLVwiautiKyTskQ7tL1dHf5KQ6EOoP8/mooEkLoedV/OLIErm1j2l+qJVKMXCfFbjFjoIjveG4S8m+yRwUHHdhPBvhg4Xm0TxwWPO10pSQ2NAHwFNER20eNw01gdOBirwrOO0mG1Wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WE3A9ip97KapG/+f8EzZLJHgMvuMfcTDYXqKI3LLlgpPAxCmWLMya5gWG3Ru?=
 =?us-ascii?Q?oG5QPMFeqYN+5vyChEPZGqyzUyOl6tCDL2bY9mofxVQdqa+qsu3/5XVuZ8Ah?=
 =?us-ascii?Q?xcm1kHj+mpnJXu99QQRBozvRAz9eYqheMfTQwBS32567eZq2nrYZH0yw4Wpc?=
 =?us-ascii?Q?x0tSYfsgbi1497yylQqZXDqRLVU+JaUD6mKdxQsxsCXNzHtnHwO1udurSrO2?=
 =?us-ascii?Q?O7lT8n17Ow51MznUg32zY1Qt+USAoa1u3W5s3bk0aE/WbgL2u+EyMOv8q0Ts?=
 =?us-ascii?Q?CD6lSUaXllmYvIXZgmg235/U0YB3dR7i+gkf75HR+//KdLe1l5eeCN+5u4By?=
 =?us-ascii?Q?6DsbtRa4QAechXp+mC/rwXp9qlMbla41GVic8FekhW+YEg3pYFe4caHyByAS?=
 =?us-ascii?Q?QBrSvrRPSdVIoXGu6PEFhCiPWMLJhXzMXFi1XIPBhwGM4pUXWQsniVE0sp8y?=
 =?us-ascii?Q?aLNLrfJXA/ejZQbO9Vpl/zHiuoxMiaKHeXpX6aH2rQaRRDH1HeQkdiUX1bBB?=
 =?us-ascii?Q?RP1wMoIQnAI8AmctJBH2RC+advzt8SKVVgJLzRnOuwaGAsUrbWabyAjkpQsv?=
 =?us-ascii?Q?4wOgNSnRssnP9ozeKSU7dYWo7i3v093De1WPxIR4/iqnnwgG0JujwgU6SKj8?=
 =?us-ascii?Q?WxYEV6Zkpe1Oq6395+j5gjJLypJJHqbT12xlINC7YLxMCIDLM/xjS9jrqiuZ?=
 =?us-ascii?Q?4nORJ2QD9gYUOWU2M+spkR8OEtkzbDl39mRGS+vORtFBr1FnEeeufbKJnLhX?=
 =?us-ascii?Q?iSFzuZaTf+k170oOOR+DCJfkh/hUmrdIuvYha+dQMDZ0nsZajV7u4C5OPfiI?=
 =?us-ascii?Q?FMqm7ANS0Pat/PBzGpSjScthV65p7uBK+MaFYCVe9w4xg4uRB1YqPGBNg1Cl?=
 =?us-ascii?Q?1j7NhxjdrwZuZs5gsBn1zLdfdhw/s+QbVL0SWS1Yfs7WFkFY5nupsmQz8GfB?=
 =?us-ascii?Q?DF7UbdzCZN8XuVVcONzB1iZSFjIUCUkgh/bzO8KL559ejGku5F/9rtxLPEI/?=
 =?us-ascii?Q?dFD4CoWv62NW3fKYM/QtuYuvWbC4VuuzwAJuAiKnm/7y9FfE9sYhO6u6upYS?=
 =?us-ascii?Q?NhrHH8gS/GTiMz/XSswfnWify8a6XAVPVoa6ckxzKNycWclesLZyKmm8iavN?=
 =?us-ascii?Q?Qa+Ur77hMxu3NpmPghJM9yokoC0WX6GRNvLWPQsHEjzZqxKbNfOiZT1Un7mc?=
 =?us-ascii?Q?PRwNwi7rtE9KgrLVGV6XyxSNzwJEXq2tMr34o/wbYyREitD4wNDw11fqfgXx?=
 =?us-ascii?Q?brLr28cF6OumHvs+9r3Y5y2bitqHp0HZzPGBhp+4XxG6BRz2bokhrAGTGn+j?=
 =?us-ascii?Q?PS658y3tqtNofFxJjW+VtGzk8YYgT8yuQJ2YEuPAYGB2NFesVKip5HvFeSYz?=
 =?us-ascii?Q?PPazDo4AbxiISj03nAF7HhtW5W1fk5bDxieHyF71ugGaHYyBOM3wVxFVx663?=
 =?us-ascii?Q?pG0Wk24xkCPVOabNS1P28jOcMnYre8EBS67u45iq5gGwqy/LjnyiEMg1ArmQ?=
 =?us-ascii?Q?8aER9GBsLl63dZfqEUvEziSgYtN9ASbD+4QDqv60iLa55uQElj76WWxxTjs9?=
 =?us-ascii?Q?AqAqGMJUQyPrh/DmfCv5JvxHuY3Fk8lQbFxmyYfL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191f8f24-9ace-4ef8-11c8-08dc59c26e79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:57:59.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dslfj1PKFgTma/KHcWlo4GhpokDf0AyRLgKBTRDOECLdPpGIo7+BiyFzK6Mop6xz3rAtLNknPLX48gCKveDmFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

The page->mapping and page->index fields are normally used by the
pagecache and rmap for looking up virtual mappings of pages. FS DAX
implements it's own kind of page cache and rmap look ups so these
fields are unnecessary. They are currently only used to detect
error/warning conditions which should never occur.

A future change will change the way shared mappings are detected by
doing normal page reference counting instead, so remove the
unnecessary checks.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c                   | 84 +---------------------------------------
 include/linux/page-flags.h |  6 +---
 2 files changed, 90 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 8fafecb..a7bd423 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -320,85 +320,6 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_page_is_shared(struct page *page)
-{
-	return page->mapping == PAGE_MAPPING_DAX_SHARED;
-}
-
-/*
- * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
- * refcount.
- */
-static inline void dax_page_share_get(struct page *page)
-{
-	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
-		/*
-		 * Reset the index if the page was already mapped
-		 * regularly before.
-		 */
-		if (page->mapping)
-			page->share = 1;
-		page->mapping = PAGE_MAPPING_DAX_SHARED;
-	}
-	page->share++;
-}
-
-static inline unsigned long dax_page_share_put(struct page *page)
-{
-	return --page->share;
-}
-
-/*
- * When it is called in dax_insert_entry(), the shared flag will indicate that
- * whether this entry is shared by multiple files.  If so, set the page->mapping
- * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
- */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
-{
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
-
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (shared) {
-			dax_page_share_get(page);
-		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
-		}
-	}
-}
-
-static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
-{
-	unsigned long pfn;
-
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_page_is_shared(page)) {
-			/* keep the shared flag if this page is still shared */
-			if (dax_page_share_put(page) > 0)
-				continue;
-		} else
-			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
-	}
-}
-
 static struct page *dax_busy_page(void *entry)
 {
 	unsigned long pfn;
@@ -620,7 +541,6 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrpages -= PG_PMD_NR;
@@ -757,7 +677,6 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
 	mapping->nrpages -= 1UL << dax_entry_order(entry);
 	ret = 1;
@@ -894,9 +813,6 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5c02720..85d5427 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -631,12 +631,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
-/*
- * Different with flags above, this flag is used only for fsdax mode.  It
- * indicates that this page->mapping is now under reflink case.
- */
-#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
-
 static __always_inline bool folio_mapping_flags(struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
-- 
git-series 0.9.1

