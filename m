Return-Path: <linux-fsdevel+bounces-37589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126859F4263
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8859B7A60EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6F1E2845;
	Tue, 17 Dec 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZJ7ZRSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0C1E1A05;
	Tue, 17 Dec 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412499; cv=fail; b=q6KrPwhNAADtAC+3ZFmu7fLQlk3NwWql9hCusCNH25hSmfUXMU1G5mr0N7s5YHNsKkB93Y+VaA3CvAL92TliROn50HjNECp8mX9Z6JuMEyN2cs17TOzEdD7Yyjcyroo0jOc8TfarmDXa1JRvINmVglTKSNYSALEH4w+LOqQhbDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412499; c=relaxed/simple;
	bh=0+rDRiFzsqoVfbEuRI6WA21Af6c6uvCFquxA0VefCVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXuID4GC0Xwb2mrzktAw8NsacOmDrBBDlKKHUZRI9JS8uMxf6LeCJmuzN/gW/AUWKnSDAKJFCEBN8Qec5c9j3eh+Ruu8O0Iu+cSSQff2bDvFcfn6DwbG7geGaFroGHw7Zgih+h8IOW6QMRuGRCQ5a6sQJ7RsDu/NLlbnfHv97cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZJ7ZRSa; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evaMrx3FYmrUstQLtFRJM9T5M0jMKOJNy84Q6yn7A0rpPt7DxMl3ImTMVsw/L9QsihpdTYymaPdFaJt9yiQeRmNmHYiGXfAGcESKRpypTtTlE8SEq/8eKi0dSvQkrBG3CI2DDDKBefy6vyKpgCGBolqT3Su0vkNA6FTarCbXaMhe9EFQztJKHDiXhKtPRNJ6+mtT7rbFYM3jaiLxWgibUd+Wxukiwo5mknD1qk02RZ0W7OnXwilIzbEJFbipA/WX1j9Au87xnhJlvwd/kSnb/epqkJjaanUAZUGJI8FhM8HnUFZ+Kx9E3DGLTjMjfpRpYv2M+zshBDYHHuOwfIklwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfjrwzS3eolUcAezllAfNyxmz0k/GYoMHQi16+Es1xQ=;
 b=Yn6ysNrrF7dbNgsJUnRBw3sPe5F41y94J6i8LRBMBB+Yx7fa33uYiTl0S4pkxqqpnwnoM8IwTyVZuIXZCfdmlTCDB+8YOhKIug+ZpnECv51DkXck0Qz7Y432SbzhtTOLso7cYDHPQ7lGUcj1DDuO31PvYdYTDi5mTojBXyNuSNQZwjJ/tE6oDEn1gdwSH2HKcbiohLoq/sVKKgvTHhf2zIJsLKmgQmEx2kXqSKqcshyYdyjw7hBhhL0QfwXlqzTvXEwixeRWpQFSCo34zs8XfUcMzhdgcBESGRUi6W3eB2Tyau7c6KoVO0eOA0aGoy3PkL/LIVECM4FZtMOg6NsDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfjrwzS3eolUcAezllAfNyxmz0k/GYoMHQi16+Es1xQ=;
 b=eZJ7ZRSalaycjhkQiIeIrTg0p2HbY6nFEWv5kxOpLPf/gDNJx0w+/kQc332OdYun96zXUXZXuDShmac7jor09BJu55Hn5S/keiU+7S/LmVWkPkub5kn8udZyJxmTScOcpFxvzK5f869ToZXnhk3z9P8VTiV/Ti9rKAg31qKt4zhiaVWTIH+9GwPrfT8T+O2XaKj8RRRaxVP2cYLXffGhgeo1cQV9TsW0rS1oMPChWPTD2TP18usn/nzNhw47tiYRzZ4Dm2xF7NS07i3UQ2LJHq3mRUteOuw2Eb8ajFNZOrqoiYCFB6ho8xhYlSaQUJQoeCTGKJe6ZsxEfIqKM5s4tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:55 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
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
Subject: [PATCH v4 15/25] huge_memory: Add vmf_insert_folio_pud()
Date: Tue, 17 Dec 2024 16:12:58 +1100
Message-ID: <03cb3c24f10818c0780a08509628893ab460e5d1.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0058.ausprd01.prod.outlook.com
 (2603:10c6:10:2::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: c3299135-dad0-4d4b-3a4b-08dd1e59be61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2YIjY2OvUgAetxaRcv2uIhwG7O+ZTsGfLJn6UVz5JHjOoOjFoZ/5/loMTnOD?=
 =?us-ascii?Q?Kgw+IXXbIP5P93kQhPD9+fCGQ20bABb93F5imPsvDwMcz4dkyuJtnQAoA+ZN?=
 =?us-ascii?Q?5Kv1/MvSNh4z8NME6JkOFCY+CXH7Tnm9Pj9rMyYdCzUG0XPeRBOmV8gujOOV?=
 =?us-ascii?Q?Mi27jnZYJvDnbBu5HIIeVx/xjJ0g3gJ/ADFQJ+i+tU7OvkjoZjKUG+2pARYV?=
 =?us-ascii?Q?uwgpDufBw2azVGpNK7pRm1H55sksow2CQLPFhetVMrxaJD3uwBbXNSzVD+tx?=
 =?us-ascii?Q?LTZTlPOkaCFSS20FCu8uNrYcXjrvsrn1FrveGw3CqE3RcX28IvlOOHi6kWNu?=
 =?us-ascii?Q?Ljgj4BEduE2Z/Aspo+yb2KV3UHbm2KU/wg71fVqf3NoO48WwWZMAs15lZUQe?=
 =?us-ascii?Q?oc1+jqFShbVgux+tVAt/Z0oHYVK+mzJGGNyFzk/s8oS7B1RLeCoSRpshwee0?=
 =?us-ascii?Q?in1VN7lfT8sj1++6qi8EyYUYKnEb6hMI6KwY4zwPQvWSpFWTdo/MZ1IHDvv/?=
 =?us-ascii?Q?PAQ7f1cr6vTplc5WQAvSwCitRACUAJNNAeC1U44Opxp+Al57pQ1rT9VLv8KZ?=
 =?us-ascii?Q?0uwfJYcYm0ZHpjXeN83uTo3o+VxtidIQRFYjsIzK6UjkKO3KMHkD4rdVdbjQ?=
 =?us-ascii?Q?s8oaB5NMr3S0I+BUrIJbym8umuidGKaSG2p/xQ5IQw4bOEU2Mnu8pof0pZNJ?=
 =?us-ascii?Q?/EAg8OHef1Qp9x5fndjC2mSBASVIr7EKViBfUkEwnP1aRq/Yq92eO/zHyVnZ?=
 =?us-ascii?Q?WgGMsJkd7oTk1rPRQebFNgCJr3LH+pyopc/aW4IPykP/jzbJKUHbvn35EwXv?=
 =?us-ascii?Q?fBBpesqz+qJpf/BFWH5gNSNonB0OAB3SYnJqrR0oqZCrvGEvLveDCsbvLlVf?=
 =?us-ascii?Q?etKmwRbwWDJ/znTflSDpJ2yDuosncRANvx4yg09cvSRhnELaeEGufQqLfN84?=
 =?us-ascii?Q?KzuU/VHoKcyVvWt7q2qE9eU+clqIp/yPSMkHgarxzrGPGoyWgUJoTlHhvpet?=
 =?us-ascii?Q?aGtQvmCvVLEstYI/6e+cCYRfV3NP52QUV70Eg0RgpI5OMvCUXu24qBVA5PMS?=
 =?us-ascii?Q?ZByD+2mrj/S2SUvbc5khXH2oG5qWTYjEjw5VhSnk8cQ6cl0zhx1ZyEUJJt6S?=
 =?us-ascii?Q?2mMKp5QVaj/hKrrngy+lAaCL75at9I8RfR+PDNpGL8ynXHUyUl2TQHWzRSLq?=
 =?us-ascii?Q?+S6JavE0AipKXDOaDwInZ3xDmzQzYY62nomKplYuq+FxX4HkoS+1OTeyQs1p?=
 =?us-ascii?Q?XVrfpZkbPgMPfgiDcI8xfxKeIGqzuBa9g8DrwMrP27qWSG0KK05QnTDSpxAf?=
 =?us-ascii?Q?TMT3mRG7NFza5KoIHpSA1q5WdniYLjN/XXjm5e6PS+A26JuMT/r1Qo1OpfVz?=
 =?us-ascii?Q?2i5Al/mcochx3glsYufO9dSHl9lP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KKFhqEHkY8KAoBq8CKU+v7XdJFat3pYw4VKRlYZo8etjmndXdo6XO/JwaRA?=
 =?us-ascii?Q?19EwVGoOma2Rw9bdKwThzhS7niX2NYTbA0g5CFfNR1RmuXM1MrvwsB84xf2H?=
 =?us-ascii?Q?FK2QuNk/b6EKglGmHOB4l8WMen8qwV3OQn69a4RPEobOaxkOpDKZWQO0bX6n?=
 =?us-ascii?Q?iyTguRnCETW9Ed3LBJVfHp0Esbajs5z/QlKv2tj9VbQVB4Sme0XklWGHDx/N?=
 =?us-ascii?Q?ggFHyqUwMAsk1CNTYjPob+oPxz7wzDkKzP+4PV//hbYjN8uK/tW0BWz+hO1b?=
 =?us-ascii?Q?2j0CUmmiZtb1tCUbKA3Bk/dNqFMBuP60hMNay0z/Pxy6OBhMQYvNtxVRd2Mo?=
 =?us-ascii?Q?7NBmmxQEwdB6zETwOcud79eh/d+fYXzRA/2jBkqmlaorV30AAUGGq8/ggVw7?=
 =?us-ascii?Q?EO8m3iStC9pXQotVIVyhSsYAUiuSgVq41YmSiFE0l4ldjDj/0XU+DcuTbqqE?=
 =?us-ascii?Q?IYw5iuXgsPbVdR4My5IDnVrWXEIPscMgfSp2Ce806TbDr6CUdHQFadjpWwuZ?=
 =?us-ascii?Q?unErUxyPHkkJjNxmyG3O7xv0a2LpluBkhBOfsQl/UeGYuMYe+ed9d32gC1sk?=
 =?us-ascii?Q?R0UIiZ6fqUybt9qj/MZRJQYkWh9/3MOZm+4TKK2ATTFbxNMx7bXW3jD0KtS6?=
 =?us-ascii?Q?DsH/GMj0bzcXEBz81NbiWPNsfNWjVFGT9LkmmIrG2SmZXma1S2A3NeW17IFV?=
 =?us-ascii?Q?1pIdSNc30fyrMllWcMb+J7xNkpqbU0y0X2n6dDeL6k26uwvPxiSDTgErrxPv?=
 =?us-ascii?Q?DJOq5lvG0yM3nOFHlWEZkjj8YJiCxrQPYWI+KcCEpi7JQdGrILmtmwUL6Fdw?=
 =?us-ascii?Q?txUqS9bnyEp8kUkTPFK3UxhbCd9oKz2+WaqrTvQy5HKNTWh5cKzDM78Bs2Rs?=
 =?us-ascii?Q?Yl9ZJYnjnXVRNl3aWRdi9sTswonni2MMLCw9rSE0hGyPNBC+C/FvfDeSPtwo?=
 =?us-ascii?Q?injFoDaFguhHy32vZbS6tqX9yAYqnK0lJRZ6UpCf63VIJ24Oo7v3gf2fWjQL?=
 =?us-ascii?Q?ucXGoKWFWgt5v/9nNlkcU1alZySAobopCeYhWEAKiZXB2Bi25o9sphVqz/ed?=
 =?us-ascii?Q?4NzRTmgoBPuxw2cfPqZekpsnyyBRdeOQJ45vgsi1gNwiQjIZZVDnBvmzVuyh?=
 =?us-ascii?Q?FgiZNPHTn9v5O1wvbITkNKdrXXKRRZejHu+E/pgtLknQKidirOnFQad+yU8W?=
 =?us-ascii?Q?9GdYAJh6uu86xMox0CSl7SclfDV+XQBKtQsSUUOnyoQYADErXsQtLDagWI/N?=
 =?us-ascii?Q?6UM/oxbXa5jm5rTnSr9Uf1ws+Lq9jrH7HRbhT05Kzc1nCkf6gPdSO2XZKpm/?=
 =?us-ascii?Q?VD/1BnxUMIUMizDtFxFo3xARioQW8pd9Dyujze9GpTaBIwMQHWTHJj6M2NJJ?=
 =?us-ascii?Q?azcCWI7UnH0Q6LBNqtkWCzm2++gUPhEVtRtuYvUal9XemAO63Va7x5JiRLr/?=
 =?us-ascii?Q?zTqaOYUyj2EsmQfLroM98QEcxIG9J67Tw6PDH+CKM3m2rrNQ5vvTILU0eE2/?=
 =?us-ascii?Q?nrxxmupfgqoSTlS+TBhbFQg6Ju5J4E8CmHHS50y4EYnUs6ZrMLulIY/ThVdP?=
 =?us-ascii?Q?2e95ju0yVJT0kpG2asvkM+xWXsfZFnWjovDxRVhg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3299135-dad0-4d4b-3a4b-08dd1e59be61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:55.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qkzvL0HGa4NMQ52hjar/LXlL+RG597VIsACnJkdHxZCCotpVRkX8VUIFRqzkS0vqwIOgTKi9AoI7lpnFzhheg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

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
 mm/huge_memory.c        | 96 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93e509b..012137b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
@@ -458,6 +459,11 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
+static inline bool is_huge_zero_pud(pud_t pud)
+{
+	return false;
+}
+
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
@@ -604,6 +610,11 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 120cd2c..5081808 100644
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
@@ -1545,10 +1541,55 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
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
@@ -2146,7 +2187,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2634,12 +2676,24 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2647,6 +2701,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	pud_t old_pud;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2654,7 +2710,23 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
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
-- 
git-series 0.9.1

