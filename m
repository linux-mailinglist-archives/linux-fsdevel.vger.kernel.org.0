Return-Path: <linux-fsdevel+bounces-16634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A358A0504
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB4DB2438E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D6C147;
	Thu, 11 Apr 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U75vI9f0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511548F44;
	Thu, 11 Apr 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797079; cv=fail; b=FwBzXo/O/KyM+cvXIHnoWpByhtJlZlA5DeLsl+iqfPLZW/9Js957mFQsTdJUrdcbO3KoPQpH/qRxXWIKWX3ivTZuhFJ18m/DFW9xFXZy2l33glK7KBnHj/BcscXgowf/bX9bjtw9pZPyow4+dfh8hgI8TjS28tGK1tpgNoFZkow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797079; c=relaxed/simple;
	bh=GP5kzdMaTFvYaOLnz0hZ8dznf9oRaRMe8dpOqy/z+XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQIAbUB/jkMmN2JoBMx6d54VoCO2CyE2Kc1tiglHqJ5+Ast1me4VsMMqGbtCMH+auHOnBPPH0VGA+nywUQAP/EVZ29hW7ra1efuPb/pl0BEJkYh3mhXA0jfupRv0b3MJgU1mdpOKiovGDdyq29AaTaMuqkdls93NiYjNcT4inSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U75vI9f0; arc=fail smtp.client-ip=40.107.223.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CidqprvEPMfM0dqDMIRnzNu6FPd7S8OmZrGQvjutX3KSBeaetj62ZQLk3PqjJVWx6xgH1akZgK51oJezxxxCYkLt0S9v/rPLh0ae+jkC9/icWxI1mX8bQUBnZ9nCrc7bonB1EB76+5djVZmtt7GU7QIMmb1LTydbHZdNDkgVoLwZU6l9gJ3+iBX5jVeiW1oFZqXptt9rdp+iiNojd2yZHVs8vOiwQ1t9ZjQug7Nj5H/+ZyvhgNTqdrvYXw5Nrt73dnSmUhI4VhXCiIn+rwd8Wn4zfuQsSW+72G5+4yoARzyReKdgPhP6kKpb0Y7TkxM5jsTWbpW64QalD1l01o9S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaAj1H/CPKptiJB6pK+WOt1+rhxsFQDPvkiTAdo5S0Q=;
 b=barKcDAGf4j1l73VHHSiLG+9tCbkyF1wsnlwOd8CBhaCD/WVjGMXfdUAE3oQqUIyojiZJ0pgWBImQDGTmXuZbJGUQK+MgNI8oXiki657T3i3LrIy8k7duU5b4drdsEPayazPJuCeYmQRSWSa9LOK3CK33vPgFcyWHLtXzT1eVc+XfaeLzhr3wePWKbTbZJRdzn4DAZ/eXx6j1JpHjFJszMW3GWcTmizPbDF46eQ3wsCK7XNikFpj2uY+XNyIpaSsHmo9ll3+NrjflIchooqyHOO3xXumh/aoNz9w0r7dIf8LICm16gWWE6Rp0y1s+aavRoaGNskSqRTFT+TwQ5EKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaAj1H/CPKptiJB6pK+WOt1+rhxsFQDPvkiTAdo5S0Q=;
 b=U75vI9f0+FXUyrPpqdGiEWApL2ueRGSa4qzaRSReD8u9ZV+b4rkruuYKQs19udEtYnl22dOYhHuUwCjtFdV+wHxM6w8bcT6crf9Ya6GT4Hy/c0Ko9d2NQjzbj7GIqebvGADL62E/3Qd2oYbt/iUQ9Swsst6pOSvajPLogwDBTPlV2E9SvIUTN5E8aX/4toConYrbJS7y7BizsTexQfx7mA+RAEJXUqkiYnPiYLPIB8n8ibHp4asTbXQCsvrUUy4AkBK83soUDxrJ54Wx+FFO7FsDp54YITrQ4vtsjKX2pK7khzmiyEqag3fk1nvDcqZwaAOaO2rdYMCvm+KZolHIng==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:57:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:57:55 +0000
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
Subject: [RFC 03/10] pci/p2pdma: Don't initialise page refcount to one
Date: Thu, 11 Apr 2024 10:57:24 +1000
Message-ID: <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:1:14::16) To DS0PR12MB7726.namprd12.prod.outlook.com
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
	A0ob9Ekf97kyhSrlUaYGt1+szfE7MUqxuDyRZbsJYNjH5JlXSZ7d7ETwNASponzmFyX4VttQfhU2sex5R2Vheyt6gE6eiMJPWoo/WKd184jZwzt6OPLV0PX24gV3DYF/atBWDFN795x8O9/bsATGRV2jRZ1tW5LRI8DYt72jazOw5gQipUCLCBiDEg1F5GamlIDJpSzRmOQrz6d4/jCIXGicKrQNaDyIv3GRqcgIvAXkoxKuzQUbjQgTGG0MANQ587DhyYTVFFQItW+lT71aNQ8Y/ZQ6WLKphdfhAhswdGDaK0taudRO79LzanOD89dZ2qOM0UyK7RwrO5t7rNUMPtkzkMnoeaYkIx6s7o8cLLqQvTIE1+Sj4Z+QMrxYwDq7eBpW6PjwTJCvSDrANCHke/UiRRGTD+ORZX2fFNQysu6qfg8GqAPncH8S+AGmVk/3zZPwTdNMkESAF5VOBW7hoVLTDC2dQiik7Bruku1FabGgFWJSDrJ5IPMC/IWOxg74TFGubRJjiwUYm1aYpzfaHNDc9wxZos2BR3miot3t5q7I21xv00eFYtJK88Bfbi2+g/OsnxpCu0DVLZWQKldx+VnwEbBVERYMyQBkhLDxm/NSvSQW9rFZ1I5jZ9TS/lPk8mXxUa2AqXDyaviwpNf/Mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q2myOfzcH9piEK42GoCzXzCj8GssQWGsJ84qECaoaiZuq5ksrOeLl0KxuHhZ?=
 =?us-ascii?Q?sPJL2CLWrcnk4tOUe9TkA91WaJGiGypXpvwZy7mvNWGng9rj65oiOmoPAyL7?=
 =?us-ascii?Q?T+h4EUmSGcYiu9LN4qEVoZCn3d5mivvcz2jyI1QIso399E30ZDgzaYVy9u37?=
 =?us-ascii?Q?9Dtys3CPPkDQxx9x2HqM8EKwKDncpqDbJeGRiNsw5OJLyE1k7z52Mc2O8BRp?=
 =?us-ascii?Q?tcl/eMR8Luh8IblaBaXpoezUENRWQacyJv1WlGdKID4csbS5S7yJojQsrg7t?=
 =?us-ascii?Q?fWIWYoLS0AtyO6ttQTzk+WgrQhrLKpQZCZXoFTvGTJoAQ8u9D64c2p908pNJ?=
 =?us-ascii?Q?SNoBoxkBOwLp0Tc47MbGpBCS+zMa8RR3VPhu7t+SBsurEn7F/ELCCq6uHe5n?=
 =?us-ascii?Q?Oad7gBh48UdaSddcpwOi3RnDI4hBP+G1pNffP7epQDstFpBxloPR2ge5yScF?=
 =?us-ascii?Q?v8SBVd7r0iQrG85hwjLHZqW+lBoG++AzcCTb/eJyHkVuvOBzLiEugOI+pRnV?=
 =?us-ascii?Q?w7vEZqVFBegtR7KtEIuHRtiDSJcyDGsDhOKoWQaVLoK4kpTflRvyfg5J2nA1?=
 =?us-ascii?Q?2TvAvr4YiecuOzj6r+CEgqBsaO5/6fwAWGF9kFOTLvqs+uwfcp5BQKqUKvEc?=
 =?us-ascii?Q?HIboL+60d2oKY/ZCIX8UfZy4SM9CFeY7Ys/5BDGgj9k+gxBcsJoIkrRzTr+e?=
 =?us-ascii?Q?JyV4Ni6cTUtju2YXodBLamZrdyIeX8BN2bmUNrh6GUFcDzfn8KbEZ5Xvx8dN?=
 =?us-ascii?Q?3hMMRL4ns/HxG8h+UQB3wcusNT/PVUncGRTLW8yurJxOnqoetyODSS7zaOgv?=
 =?us-ascii?Q?0NA55hIRZqvaKTupYoVLCWTosD7XcyCQ+eU5G930r3vc0HwhMZ6uZMxl6fLC?=
 =?us-ascii?Q?kSW4oi+g3KEnwFdNqpvv6LYg+E/sDV2kdTNhT1v45g+QpiQlxA5SFfub2+8S?=
 =?us-ascii?Q?Hyo7SdXtqLeOopjqMRrnTksyNGECXk85yaLgzuoeSJmKmJGlHZs6f4ad6TAi?=
 =?us-ascii?Q?zfY8ZxLx/BHCNW6eyE0NgcJgov/2yuXyp3d1fsTTgPmUsG0D6WLu7o4VRzqF?=
 =?us-ascii?Q?aCz+UYgJXKV/CNx2Th4TVmuifiiXqbGV0H5WFhQls0d1ZnROEiAuVa3HF9Gh?=
 =?us-ascii?Q?6tCpbGNnyZkAznEcYKN1CETWFvvEXFo8MXSi/yXOp5vi4WyLTLlLxX/h6Hb9?=
 =?us-ascii?Q?LmG9dJlaHO5Cinm0Q4pFiIFgmlBbJcAloMwOlSIW1R/jJTcspmeV28D52UIL?=
 =?us-ascii?Q?B2T6t1b0nMtuCR/U5NsLyoc6gRkDt27WSd7xCJSqEPYrLWEuMhivJKL/cyfQ?=
 =?us-ascii?Q?5pE1C7fzcAZsUDdig2OEXgn6z4YunQ4oLHpoI3W7424U0McO/kwnPGITXDd6?=
 =?us-ascii?Q?aAOpFzBqlY1VhDpxFD9VTsx4Pp8Svc7sf3EEie9oJ6qcNusWwE04ZRR3IcjY?=
 =?us-ascii?Q?sZYRYdbIPclG/MkASU79uWUITIss4AVq5hkUyNDZ1ffnCnqmv4E1dr8go7Yv?=
 =?us-ascii?Q?qlrcmYMqsUe+vevlPjxAFiyR5a6xVxYtMHg8iBlPsV0SXAhl/5i4bJwbuEhW?=
 =?us-ascii?Q?/sjE+6rKiSDdFYxCUpLB7TfR2ynGcMVtgmatEeBY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c008d3-71f8-4d18-9638-08dc59c26c29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:57:55.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BluJMLpwV3Z/xzsITQRcLc8+5JZ8HV5EhxlIKGm3g/2qpD8I3OaBC6zIxp60YxinhB3J2W2ZImTt27of32Bv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

The reference counts for ZONE_DEVICE private pages should be
initialised by the driver when the page is actually allocated by the
driver allocator, not when they are first created. This is currently
the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/pci/p2pdma.c | 2 ++
 mm/memremap.c        | 8 ++++----
 mm/mm_init.c         | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index fa7370f..ab7ef18 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -128,6 +128,8 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		goto out;
 	}
 
+	get_page(virt_to_page(kaddr));
+
 	/*
 	 * vm_insert_page() can sleep, so a reference is taken to mapping
 	 * such that rcu_read_unlock() can be done before inserting the
diff --git a/mm/memremap.c b/mm/memremap.c
index bee8556..99d26ff 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -508,15 +508,15 @@ void free_zone_device_page(struct page *page)
 	page->mapping = NULL;
 	page->pgmap->ops->page_free(page);
 
-	if (page->pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    page->pgmap->type != MEMORY_DEVICE_COHERENT)
+	if (page->pgmap->type == MEMORY_DEVICE_PRIVATE ||
+	    page->pgmap->type == MEMORY_DEVICE_COHERENT)
+		put_dev_pagemap(page->pgmap);
+	else if (page->pgmap->type != MEMORY_DEVICE_PCI_P2PDMA)
 		/*
 		 * Reset the page count to 1 to prepare for handing out the page
 		 * again.
 		 */
 		set_page_count(page, 1);
-	else
-		put_dev_pagemap(page->pgmap);
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34..da45abd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -6,6 +6,7 @@
  * Author Mel Gorman <mel@csn.ul.ie>
  *
  */
+#include "linux/memremap.h"
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/kobject.h>
@@ -1006,7 +1007,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * which will set the page count to 1 when allocating the page.
 	 */
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	    pgmap->type == MEMORY_DEVICE_COHERENT ||
+	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
 		set_page_count(page, 0);
 }
 
-- 
git-series 0.9.1

