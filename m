Return-Path: <linux-fsdevel+bounces-52184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB70AE00FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528EB17AA2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396F289348;
	Thu, 19 Jun 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jinulDCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCE286D7B;
	Thu, 19 Jun 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323570; cv=fail; b=HRl58wneQm0uCkj4sc/XAR1W06DqYipvD383kHvhOOQK6pio5U9MR/8bB4ZzmuAsnHiY4BPu/cWAm3Ht7K5gwlgYVDJl0TrHdT9gJ3gDwXgUrWpbc/HYNxYwpkqHxDqUtVfGEHtv2hWemsosemW/Vyl9DQw1QDxeT7jfJsCfu/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323570; c=relaxed/simple;
	bh=6D1q0C6i0JrA7uP8/GFMb3rgrJwdMsmx3i1s3hWj4OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGzeZgV4A3hGzqVPbVbvhZDAdpiGSNf0T0OtpLly5SFKK3Y2QrKP1Mds/k4FxH0FwZoDJg0LQ+Kzq0cZ/LS430+jyRDZUoRbkXV7dbb2wPZRmwR6sLEJNdXjxGe/D05+YfaszWEY9tH57W+iZqSJtebj7MD/Uex7ZSkNLcdXSd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jinulDCt; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoD0yKOZ9gz3jy/uPTTen8fVlDB/wP7VUnGa3CnoeCaIHk8LF7eY/qdAfGPIi9crReqS+GIcmIwqwdyIzBREem1zTHS8bGafSSPLKJsHzI5l6mlH53GTag7oWWqqfcoSEF167ZLO71YbdECmbaMaTebydp1XlK1F+hglRIXWqzDBdbQJXn7eLp0vK1mESYoql7OkM5QUBxebO2EM3jbdj86O/rEKdrJD3ojyDT9hHlHDjyO9a/+mSXEiMbQqx6xR9kEYtq1Rn0eKLSo2GLq+RtGaYA9xzLNOwu4tHiJHdXjKncgGbp8kttzmEjKhNKRAom7jIrY3G9UzE5JwYstU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBlhFNYHf/H7J+iE1BwKelO7XiSj2kzaOPLJW8HeMcE=;
 b=ZXSy2SsjvwOMBx00pYLZ1OqGWov3QyC11cPpdLLtyuwH9hjstgavjtSxJeUS4Kw7RQ9Ds0jg3Ld50GHsVsK0jbKRSOY6yh3JmxaxLv3+WNCTHs5N57Tb15ciJcAFLnF+WWBC9wj1vpnIRA4hiTK1T/H/7GbIsPxQINxQ7lkdLLpm7PbI7MG/gPkCm/33qvuEvpAtvR1mJ2vECEEkMLUAZdKsRStMxXLXddrbiRFTeGnxHfNHaDeKPLwJRGhLRVGgsO3K4V4sLoX7JryVK1pTYSskT8eDIgDnIWz5nL/E4PiTD8AHSTbumVyjusdRp+4kC6prlmVfs1KWZhtDaOvtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBlhFNYHf/H7J+iE1BwKelO7XiSj2kzaOPLJW8HeMcE=;
 b=jinulDCt8ux6iGe9N1IqAx2x35FikcWotkn+2iC0LWzw6yyL+vhn9+3TZsj+1bDA6XgGEJXnDYEo5aZseElLHLAzw+ux/hJkJ0bnAa1DLdzPQI+z/qFlbMPs9fGIpXi2wDmet7y6xQIjcC1QIIUBH24jGS+VfbCaDNt+jQjp4TQjSRnia8zuML4yYDqSJysbHdoddPXOtvsZkFosJQy5nn7Lwndkt8NvwNMR2vw7OBXT+yTie0p5AA73wE3uU1fFXWwcjjwYrWrlscNoHOkhLpSybiJiCrUrN32uIT9cKDVIyAh0ENq680O9PTmr0lZ1MVDqLXM9fZTWpPCmpOqIvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 08:59:25 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:59:25 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
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
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 14/14] mm/memremap: Remove unused devmap_managed_key
Date: Thu, 19 Jun 2025 18:58:06 +1000
Message-ID: <11516e39f33f809292ffccab1d46062f9bc248b3.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:10:e::21) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: f508074d-3982-4562-6599-08ddaf0f9765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6cFVxVnORHS/1A1DIr683Tf1lWQnm6B1YU5BRgUfymXjouhu/0XmK6tkA0v?=
 =?us-ascii?Q?soyCcobciCAQpr1upnl0/kiraQuHWdEso/yzX1PkTFeZwqaXyLcaNzEqrX9T?=
 =?us-ascii?Q?8ksJU0wIOtlbvHLrdmHpWZ8zjs+GR+1w3SCQcyWgUz6Fnl+NVacEe5pFv3pQ?=
 =?us-ascii?Q?/ptnLLaBWKejLP0f00Ii8XFU57ITGWTTB9Bjk1RypWdHu914TY0HhLlu5/82?=
 =?us-ascii?Q?Igdrt7M9N3oNccbkIWrip9S7Lu5ztRUprdrGhRS3O8r4oFOB9W8q1B5ap+Sy?=
 =?us-ascii?Q?9MO4tBHVp+SXyt9xS9bCh1V9xWKqNy2NBNDY+lLlBgGOTx51T/1nRc9ECqi5?=
 =?us-ascii?Q?/lMCyEaC9DuDTnrrhfrKXWzxLe6QfpadbCpobJtYAWYauFsAZwLJ83fm4O0B?=
 =?us-ascii?Q?FXYGVDh+locxE0grpqoxchHsTScluf7YD6nYMosjC7ucUfhQAM7QBg48pR6L?=
 =?us-ascii?Q?H1KWAw/7vKY6q5C7mehypz+D/EM9+2oeYQVb4CFnzkyycPppB619Ghh0gAbA?=
 =?us-ascii?Q?5HwsVEbYM8cbW6GhIcJO5IzJF7lQCR9byOpncryGrhCP/vh6JxoeSHhEztUK?=
 =?us-ascii?Q?q2b5NwR4hUE+SPqwUVKFLR1KUpbduN6/90S18Lmp2hony/KszmZEX7oRkY2Q?=
 =?us-ascii?Q?1W7fgTYfkNa4o6Mw0+m1i6sdl0zm4sQ51xswGJZ5BCYROO+2yUQG+OCYEBD/?=
 =?us-ascii?Q?/iehQt4YwnBCzU4swRBclO0WkDJ5Pi55w2owdwkFyH0YkHbNsucPmRwP5Ixi?=
 =?us-ascii?Q?3l/5gmiPFvAQXDY7mys4IBm2tQd+16fHMUc1MjrZT9ksA7Y4UEbFh1eywGpP?=
 =?us-ascii?Q?sY22H/xiAHPAEIXKp13ElDSqK60X8nxghJ8a1rDNv6CreR/F9MDkgIQ4HE3A?=
 =?us-ascii?Q?disPnxsBaPOAQf2HR+cRCvk/4gpMqG+HGf+837ccJzt+XW3Oy6VPFLvN0S+P?=
 =?us-ascii?Q?kAs0aFbQZUwHa+KWb9MVSmGQE/IrnEW1UKtKJJavglKyFlzg5ibm3m+FaQm8?=
 =?us-ascii?Q?VZ3Y15fyhjl1GfGaPG3I98wK/ydiaB151HVLnxZozqyuvljdYbSRaDE1EBF+?=
 =?us-ascii?Q?0Kz7ZgrKYoMfx6TIPYUogEB8c8BL1oWcmTIxpUAsP1Qj343NUu2hkKNbTgk8?=
 =?us-ascii?Q?nEnaqTrCbklGRzJ5Ah45xsuY3Mv0x8zscA5Cr40hdHayiMyH7IqQ9RZrFFdZ?=
 =?us-ascii?Q?KYWzKE7+C/bYoFsnR7+CVxnY8wIYTjmbsbfLVIzKGF4hCT6mUVyiBuasQa22?=
 =?us-ascii?Q?s0vEuDBqOL2+G/XFW91MK3Vzpb3x0LEZv/mWPvoOpX4Paf1+dfyqjhUFrccH?=
 =?us-ascii?Q?m5JUp9ylTLYZGGUc+4ZE+xClY8kk566dDnBp5nkSUyFfIrP5ZDlfiwpRygGY?=
 =?us-ascii?Q?klz/6MxibO/dcWg1N8Rf3X1A/o2FQnQwwkQTMZbJwthtbXqPqBMN3zc47Wq5?=
 =?us-ascii?Q?7chcrHrtLCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Nxewbk146M5OxWqwP9XN4j73cQv7ZgTD/kaqf5rJABkOYCewSQIwW+2mWCy?=
 =?us-ascii?Q?ECro7xGf1kc3/apbquBDs5olpfFbYIdhZm66WFyv4UOT37o4u4bJ4jV/zzce?=
 =?us-ascii?Q?GePhMI3stK4SUJmUuMW1jlAdFkypU8TZu/5kk5nJoquspbuyKc0udsOWEYh2?=
 =?us-ascii?Q?FKzMijBMgVVd8ywExBmS57XgfYG3nsfGXn8EvUrlRvc1ybbiLJDFnt/1iTv6?=
 =?us-ascii?Q?W3IwRqsPj46TF6tB9fJuJ/leKjxnjdA+Htzcpf/ZzQ1YgTZ8y4ahQSjOeozq?=
 =?us-ascii?Q?RgHjxI2U1XdciyZTQSBbCZxa9JpX/cziDDvjo7+rqitmrBmJOrnrZQedgOPF?=
 =?us-ascii?Q?Z5N00RNOCl5QlwA9Ca0z0kxaew6LT4AvPhTVGRNrd712DDWzvuaQ+g41NLhF?=
 =?us-ascii?Q?Y3TAqs1SyyHnKkoYyvJ2SQAlsbYA82VrlhqQbyiIuUn8PQxLi/CEa5etAsqj?=
 =?us-ascii?Q?BkzFvSG7U9K+qwssdLWNw+0d0Zh1eBF3vvk1uT1da0EQQvbiOwBCkcpo1QMU?=
 =?us-ascii?Q?l8sET/pxWsAyeznrHSMOS4j+l3PNaEcEkYbpsV+lIuK1yMfujxKXq9bnf5ga?=
 =?us-ascii?Q?ehiPcoSPId2GgDaRacUxKn9hALCqaAi13UxhoRzTJaNjS1FWZMZ3/uK0MGoI?=
 =?us-ascii?Q?AtNxWQ8T9DVJYvN5iKT7Bfh/nnjYXpMRCgXl/XIBXZ+8mz/yKpvWaS6Li1bK?=
 =?us-ascii?Q?jJOElVP2ZxtGZ+8yQtoFm/RLGXvPw9yJihd1JYbi802Xl5PXEAKbkcaY9ZPO?=
 =?us-ascii?Q?4SSkf+BnJUs4+T4YeL3ghnO0phUnqYd0mGx1jbGYHefRbbTdmMGTAKEyfMRY?=
 =?us-ascii?Q?+m7Gk6FwK3jDOhZQ2ZwEzwYlmEWCNvxak60hHPcvDR8Ph99e3BJPoi/Oiy+O?=
 =?us-ascii?Q?d0jqqiCJuYtbpy+VNjteC1d2TycjrX3htaJzl2DkirY4aUk04BGizr1++Cd9?=
 =?us-ascii?Q?NJUKs64Ov4VdNULTYzzSHI8vOSV5KO18aEchWyrzDTr8GUB0bWKkqIKh1vY/?=
 =?us-ascii?Q?9I8uPbdJ1BBxbNOS28jtaOxEsB1xJ+Ium2ioq+0bZwsGCJtyJVF8hueZgT5U?=
 =?us-ascii?Q?crXZHW60h6gdURjHVXWlRC8DIa2OZPpKFbjmm7+ERpYvS9Q3/opmRRGLx207?=
 =?us-ascii?Q?T9zFO1j6EvBj1GH7j6cqILQqhgiB9zVogMun71g4L+qm/3daNqIdpBjdo+wK?=
 =?us-ascii?Q?5z2tHBgI2F5B4oOqad/BixpVTbMlMltfFQOTU/M7wRkiQJi6XmV5tt8/ND3o?=
 =?us-ascii?Q?EvTpWGzCUZYEhbFCae2i0wpxCITgIeAdru+F4tLGOb5XvM2/9yEkCutPNSa/?=
 =?us-ascii?Q?9ACp3T97tyfGwSvKEhfcuMZQYjcwjinygAjWgzq/t+nXMNNqwhv/GwF/ZiJC?=
 =?us-ascii?Q?T3j0NllUeEvW8PNtYG/GfZjFczsjvTPReCvdRYMJ2eMS4ISZhdnG6g6QR6Fm?=
 =?us-ascii?Q?0eDE2ldvrGEnjh6CjBIeX4lFHeiUo07QHGynOaCr6i4ihTZU3IaQ+Xlyffyu?=
 =?us-ascii?Q?A1qt1wXN+o1U8JuHld0yMXSWyvq3DlU+lWe0W4V/CQeDv5tzNb40cRxBeLJ8?=
 =?us-ascii?Q?+aU8FBMfLszWVqWGPBZANhKJ1Dj9V38MZIysu3SM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f508074d-3982-4562-6599-08ddaf0f9765
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:59:25.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3J6/K8sTsEufbtE9ULxjXPBT1I7qk4SDtBvbSIen6CgI3eOzd1ROxyetGn+Iq4RwDQzBduzbMEUs/Zn7Om1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

It's no longer used so remove it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memremap.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 044a455..f75078c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -38,30 +38,6 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
-#ifdef CONFIG_FS_DAX
-DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-EXPORT_SYMBOL(devmap_managed_key);
-
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_dec(&devmap_managed_key);
-}
-
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_inc(&devmap_managed_key);
-}
-#else
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-}
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-}
-#endif /* CONFIG_FS_DAX */
-
 static void pgmap_array_delete(struct range *range)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
@@ -150,7 +126,6 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	percpu_ref_exit(&pgmap->ref);
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
-	devmap_managed_enable_put(pgmap);
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -349,8 +324,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	if (error)
 		return ERR_PTR(error);
 
-	devmap_managed_enable_get(pgmap);
-
 	/*
 	 * Clear the pgmap nr_range as it will be incremented for each
 	 * successfully processed range. This communicates how many
-- 
git-series 0.9.1

