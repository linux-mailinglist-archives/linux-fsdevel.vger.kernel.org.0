Return-Path: <linux-fsdevel+bounces-16638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D175D8A0515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F591C21625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95151EAE5;
	Thu, 11 Apr 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDAo+hNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2131.outbound.protection.outlook.com [40.107.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF0AD5B;
	Thu, 11 Apr 2024 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797099; cv=fail; b=GEQc6mlVAnVVEj+Xnkw8+6tsExDdGCqBZj5QeJRTDQUw1t9+AYnLNtKnciVb9qfrBRABvX/UyZjEWxL0ma6Ky3vL6INKF9EAg2qkyjXVBG4SFzsUtWAkeaujTwegMLxgYEll8nlOI4oaifNF/NGHNM3y8EhNEsIyD/uwQpYBtLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797099; c=relaxed/simple;
	bh=gK1xsCxZYFiKiil+VGMN/+z6nA69ORQ4z4X8SwEDG1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2rDlp2LKn7xOMOqhN26QEqeZsG031UoERHHZiAZCuSYO2qwvkNGojTGuI2ri8+QKua7LAvo6dTCSUHEEhHKY3sJ1lfZYF4OUFe0Hc+o+BtUlWxSzBym0CPob4kB5nxfSGpooDAD//9X3RQ/Cx0U4Kl6zxQ6WUjbUhK00+Sa+wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDAo+hNH; arc=fail smtp.client-ip=40.107.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKTmaF7f669jxRk7ICOO7chK3TtbkyVjWUTXeazbfU7asGVcNrSJoGI6OFlhbhj3Myse6gqf7fKOA6HV+sbMv7YSSfcG740eEMYQwDx7caW9x6MhQty/Xo/ZbFnB8YeqvzkBD1xLSF5nwlpq3yiaqPbhIWah07TCf/cQC5mUesrX8t+kcpqvG9CCM0wMdvehueBly/dBsOn6Bs1sVtJ9DdZ+Odx7wXNJg5nx+c9E3tHIhYxa8VFhYRHHXwGOvihyhzlw+ngUHHagzNw52EIMa6ymXnTFGruwqydQ7Qe+EzHu61lpPtNWHVCqgZjIcfsggE2PA92vnAhcrdVQDb7Uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/h1EMLVK7NFUnKLypFO2MBHSY7yBZMT/qNzpdtdW1k=;
 b=lX2/O5PoYfYyTkzzLOwbXNsqiaabN1sA5BTT0jZWCVERiniVTsUyCy+Vx4d0R8LN4+p2vdn99CsVcScIIhKb8M5AIn1iR6iuIdaABsJabwd+xDoHIL1DYCifCB0tZUcuZIW/P2+IAKRDEyE/5nN2JP3pfwdrb8HSuHqeafhR1Ih2kZlsT8/392bbkUF8jrEh8YK5M5VE11Lz6P7pNnPla8B4W7WAdzUMmIcuPydlK/fR13buLK40gp2wx5sJP0WDH0fKvSm3rXROxBqrCT1o5oFJoyqmQU8MMVnMyX7AZ+NTzywxTVrghcJlFspCZPEE9fuehhJPkStXWpqwn55iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/h1EMLVK7NFUnKLypFO2MBHSY7yBZMT/qNzpdtdW1k=;
 b=dDAo+hNH1janu5rj0jcZZAh9FhyGOljehJdeYoXun1CduYD2NrqF3/0doydcOpIVOaRtjm6oTlFHDUh2R4VQbq0KNvlJx5jg1zIx//FUmtUj6+Li9MhsrqJUN7+prc6fJvnvCtH87ysYB0TjCVdgrNSx/UjgY8E33B8fYoXbMXhCWTV7cCiERiwaVp7IhThNM8EmzakZ9wwlkjGnpkn2hyn/31FGgAvZnlb6oScQK1E6i66skzMtZAjmaQ3EwBUAPjUKCPR99LT2Z5Qo0RsILm3BxJI2U4biApY4qMWoexamLYX3bBklgeYZ/POSMqrPjqQexUVXxClR6Xi371lWGw==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:58:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:58:14 +0000
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
Subject: [RFC 07/10] mm: Allow compound zone device pages
Date: Thu, 11 Apr 2024 10:57:28 +1000
Message-ID: <9c21d7ed27117f6a2c2ef86fe9d2d88e4c8c8ad4.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0040.ausprd01.prod.outlook.com (2603:10c6:1:1::28)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
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
	O9x3iI3aOfgHlL5it54LdTb2eIS/EWbVs/IJ/rDy3dbP0wPdpOKz13qDydyTsA0kGjG5LyNphLr56a24lGeoKhwKYQIhDEEEZWxgYxDzRYBi44X9WnB3G/N0vu6HYRX8eYsvHkSBkF6MO6B2QIAEEiwSS++baESirP/xbOpc7QWdMfMmkYcK7+P4sK/9pd1AUoBXvRfPaD//pRVVi/Z6OC3l8s8o4U3rVL/LRxcC/Qct2dY5GpSn0j1nUyRdtoIPHRgpJkuI4WdfDIF53hAVW8aeBEWKTumQ0MNw35W1BwB1saRLAqnfC3EFjXqKVuRvyCwfNYozQDT4QHclRae54aCjiSpxMREGrq7lKl+om2v2phPR1gvW7YVp8Z0JhlgVTnUVskVl36RvEfKxtb0N6GD2P8XfVQVnxLexxKj/ngodoa5qZr3bf23Z+hBdnKu930RTALAIV7vaih/D2if6LDsv9cTIUIiFE00Khwbtpomnmp7KZgUtEYvnfJqmEzXXQcMqPzJEUc07JcJZQN96j5WGwPnd+8NKesjGCclVCEvRaVJy4VY/4t276TSyudHP/Ijm1+YMNTkjxid/C9/agop2rTVrckhen2ZLTEwmOzzgTMKi28KlhUqzqTXNDUxxwetx7jNrWILR0qb7MYeemlNq7JyWsOWqEj2nTzynH8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3WcgEB7AEpVAOiGZoG1MIz/vDLkJJ+7h9HVUYcy93LeU8XqwCPi1Sc/nD0A?=
 =?us-ascii?Q?QMjbl/ILFBNPz/i/9tdpjHje18z/S0EBw49i7hvrj2yMlOICNK1tCq1geCfU?=
 =?us-ascii?Q?UR/UW59WhxV7kR0OhcLIDrKfCKmpzfOfiKsaI0EZB6/nvCSO6xVPKYLzDjQy?=
 =?us-ascii?Q?brIEKlIEyEa+hm/yu6/p2/sK0ywbZru3lUEPTfYPh0E9K+AIZdNDMl+kpmsE?=
 =?us-ascii?Q?MG5MA0+g51D7rJd2u7agaLB25BwIh3+x5LTHwgewbN6KUhkDtvC+c7okGA73?=
 =?us-ascii?Q?ye8tup7Z6lL8rO0Tb/j+iKttXcn5MsDcz7NEBuRs+Q0jbIEsciJlzUJm79ox?=
 =?us-ascii?Q?iOta3HYXzLn+hx2Qt3ZTferlsPvyI8GRa/34MbJ7NzdVZL6SVNOi075C6wdm?=
 =?us-ascii?Q?qJf6YI6WVOotSgH8HSH0Fjxs3mO5gLSi/d9Hyu3scnigKxS0Vo+n+pe93qqw?=
 =?us-ascii?Q?8Immvwl9HHfbt5sMk0So9l3YMnCiF+3sMQugJFdes7S0NqqlMrvUzHRaBBGc?=
 =?us-ascii?Q?qocp2+PhnVcmzRSnPAz3nWZclQYBI2aa7lJPuT61SPGRJ/fIjC6tQZonzZNN?=
 =?us-ascii?Q?yLteDmPMHxDFzFNszpf+VUlHko6BogDmOqYkicJbdV+Q9kzZd/CqThpRxA9b?=
 =?us-ascii?Q?YbcUQWUyep1G8vccvesb6Ra6m1bW0HGLElVqBCgrr7iQb3Om9jQqqMGRJnPD?=
 =?us-ascii?Q?8MGWw57qxVhGvVj4kCAJwtQzDQqExXrtbNJ2egj2Q1UqJGdFC9aa9W2IhS/m?=
 =?us-ascii?Q?BoaFF6WKEPGgbOz/UL/jXc62JDDNtPA1oaMUDxvHiOJgwsyoi787NMD/gfYM?=
 =?us-ascii?Q?3viwjUThzX1xS3OjkKQ2cMLzFlL9E06aZh0V3vGkZce9YdYYPgKiBl8QHLR0?=
 =?us-ascii?Q?asMDz7Hbj1FYwsaMGhdntKrA/m7aXoT3+PBGyjlK3TL0qww76CPoxBVF3ORo?=
 =?us-ascii?Q?pbQktSQYD3+lOijJbcNgjmoQedWLgGymJCzmn9qS3S0fi+i0l7kSMtbYsM+B?=
 =?us-ascii?Q?wK3F4SDTa6cF2qNjUAi+c5kxqxcEOQdg3F7ccgJs9eU0y5UXqdFbj26aNZZf?=
 =?us-ascii?Q?Q4U5H+bSSS4Ju2MKirlVc73BNHiq9on5Lk43DPqc1wJEFtt2jmAOL1v6KBL6?=
 =?us-ascii?Q?lgrhLamyKcbRMAeyfS+mlrPL+gc4KtCUrjkMwraCa51Z+2cXO7ft2Cq7SEH4?=
 =?us-ascii?Q?MaAZvHaypUn3s219AxSlQpWwaSV8zBJhsAmwVH+yIg698fNETGHfOqauL/z1?=
 =?us-ascii?Q?iqGuO1vhRTl8H0zC5XCWFpv82MymZNpEx8rOLRGujbcOPLjB9E5zZ85tY2qA?=
 =?us-ascii?Q?qoZs2Od680f0Ec9FV7pXp65xtblLzgChSkNPJd8P94Xq9MkViZiGtsMtF6kE?=
 =?us-ascii?Q?xs8sCcpzMd3jeeG3c0+7TybHIInlEEmTkRJblRstGYOu6+mKp4IY2Znpj9Z6?=
 =?us-ascii?Q?4esF5IWdcvGVASt+rSCf0ro/olgwZoYKKepLNGRmsLJTgofwA7aMGbLVo6rq?=
 =?us-ascii?Q?+MWLmXD72p2yOPOpp4iWf4I8t6UyWId1TRwAgZhxkJwjfCSeQTDYi2zrBNpC?=
 =?us-ascii?Q?v2LYgdN5MgsgArhsrL9WZ4d9UQ40p7u5nixf35fm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ec5858-59d6-41bc-b7d2-08dc59c27752
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:58:14.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2ELjnK2n3whUC0cjrcjuzrdoIm1Cny57oRxJebZl3WnKEpO48XrdA8pgS3Os/3t3RwwBiHdeqOz8nIZuB/AvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field is common to all pages within a memory section.
Therefore pgmap is the same for both head and tail pages and we can
use the same scheme to distinguish tail pages. To obtain the pgmap for
a tail page a new accessor is introduced to fetch it from
compound_head.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
 drivers/pci/p2pdma.c                   |  2 +-
 include/linux/memremap.h               | 12 +++++++++---
 include/linux/migrate.h                |  2 +-
 lib/test_hmm.c                         |  2 +-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  2 +-
 mm/memremap.c                          |  6 +++---
 mm/migrate_device.c                    |  4 ++--
 9 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 12feecf..eb49f07 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,7 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_dev_pagemap(page), struct nouveau_dmem_chunk, pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ab7ef18..dfc2a17 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -195,7 +195,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_dev_pagemap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1314d9c..0773f8b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -139,6 +139,12 @@ struct dev_pagemap {
 	};
 };
 
+static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
+{
+	WARN_ON(!is_zone_device_page(page));
+	return compound_head(page)->pgmap;
+}
+
 static inline bool pgmap_has_memory_failure(struct dev_pagemap *pgmap)
 {
 	return pgmap->ops && pgmap->ops->memory_failure;
@@ -160,7 +166,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -172,13 +178,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 711dd94..ebaf279 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -200,7 +200,7 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
+	 * Set to the owner value also stored in page_dev_pagemap(page)->owner for
 	 * migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 717dcb8..1101ff4 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,7 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_dev_pagemap(page), struct dmirror_chunk, pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 5bbfb0e..a665a3c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_dev_pagemap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index 517221f..52248d4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3768,7 +3768,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			ret = page_dev_pagemap(vmf->page)->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 99d26ff..619b059 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -470,7 +470,7 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_page(struct page *page)
 {
-	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!page_dev_pagemap(page)->ops || !page_dev_pagemap(page)->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(page_folio(page));
@@ -506,7 +506,7 @@ void free_zone_device_page(struct page *page)
 	 * to clear page->mapping.
 	 */
 	page->mapping = NULL;
-	page->pgmap->ops->page_free(page);
+	page_dev_pagemap(page)->ops->page_free(page);
 
 	if (page->pgmap->type == MEMORY_DEVICE_PRIVATE ||
 	    page->pgmap->type == MEMORY_DEVICE_COHERENT)
@@ -525,7 +525,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_dev_pagemap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8ac1f79..1e1c82f 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -134,7 +134,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			page = pfn_swap_entry_to_page(entry);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    page_dev_pagemap(page)->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -155,7 +155,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     page_dev_pagemap(page)->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
-- 
git-series 0.9.1

