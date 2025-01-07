Return-Path: <linux-fsdevel+bounces-38527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A427A03640
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064C33A231B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759F1E571A;
	Tue,  7 Jan 2025 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eu2MCoNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7711E492C;
	Tue,  7 Jan 2025 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221429; cv=fail; b=aTMzx7Z3+Y7tW2LzJVH5f1Xbx8Xu9d4M/YAGR0kWU6DOzasltdmVPTMC06ZXCopbRJOIS2Nn5TyGbu5CFiPPl7KUjB257twE/qmvAantm6kPa0IEH6bSDvkImAhJ5/cDdTIWgJnhN2tVn9NsKn787GJXDw3zm+q9K5ty2blHe5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221429; c=relaxed/simple;
	bh=N+51V8lACYEWubyNQjC34oHstVRuzL6ZspnPk3qEV2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfaVbOE7tkmln5lvPGEF92bPA4fRVNkQuCG6KjUXO6t96WvvwVkdkdJdyA3MhlqRrVTnfujK/krl+R824+2xWcmrvFDWFQZ4Ejgc8JKc2TkJLjgnjC1ltZMmHo3kpY4EX0jrsdkKu17dwHM+nB1+5qEbuHWVQLifFvbHjXWLpX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eu2MCoNK; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdodkYuEQ8mZAfNg3PxnAFg7HdZKGtqhzdm8nTdKX/fC7OFNJFJefOY2GHCIozqvgauPYvOtCOnQQ4CXIoo7kJOi2KHX9UXLgdzspJiTvygc6KSJ/3iM9MGTa1gh56/3vfkjnSRu2z8yI67ITVvWjOxiYHTlH5Xw0OOiODuqciQAdYi8d7DP6ppkoVe3l0LMCTzxOCYZhROqHXimgSTWL8rBGXJipT17d68PEWn68xPLxR0E4a+PdH60JwxdcgxOAdVBdGHvXJBde5PAzXv9KxBDdujlZAoqbVtjkLfr7pgus0Q6AkZOHi/d2bzHfkggM+iICi3mWPNsGI2twgrNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWLD/0xp0BR6MUjdXJUQ+QA/Pxu3/82VW88rj0w5N0E=;
 b=NbBxUuhP1ogbM70t++8AARvqDAiWjt0+ZgTdGotqb0oSZ55Q0dTeV+BIAWXc9WWq81ceYvtnkwW+wd1xOgDwMz3XJNh+bftULYZ7rq0VnoEZugERz/isP0jPOKYyzPtsNPSzYOqiEqOTLmZKj8SM3a8csm7rfMGjeSTmHTuYQhgy4Ywt+It3UEz6CLUk+exslvmrDM1YqP2WjI/fR6bAco9mSyJyswPc2Lk9cT1NdXfbSPdHpzrl15dlyyzRhCkhz4hKFIABER+sAbrAHl74dq4z6VJAJnnWDfQ5qmupwLpp/jNYdInNF56hlGZHC9AKqXGIY++ooitwvq1fpc9T5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWLD/0xp0BR6MUjdXJUQ+QA/Pxu3/82VW88rj0w5N0E=;
 b=eu2MCoNKZXLpOde6x+8LGxb4cpiLFNjqTKmopaNRWkmdoXPtICpSyh+JPxzAC5RQUOpLWICkzZNgP4t+bj8cJvdLkfTU3fV3MZGhdBa9alrNlXHNLBhysswcELDRQ5BNtPc7+5KpX/vL3X2e35hK/Eo5nIb7ly1RgNuAGlZ0lhIkiKdpO1Ji3N2+34vMIeevmgqpWRWo+h/xVb9l3ybKoEvCGCCBOgX3FS2pJFpKHpqa4N+kAm62HdcTGRpmfbv2OsIZ9Gv9URyP7XUCVG9mEdgrMWKCK+rYEhWkLdeQ6jL0Ew5C9loxtH0DJHPFRyrtnDWZCHfTzCn7oBBglbOs/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:40 +0000
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
	david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 09/25] mm/gup: Remove redundant check for PCI P2PDMA page
Date: Tue,  7 Jan 2025 14:42:25 +1100
Message-ID: <ec7762407bfe4a1cd41faf89b35ed393b592a816.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0006.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: f7206646-b6d1-4f67-d692-08dd2ecd79be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nP3GNKjxXyNTSlUTGmIG1P9OutP6OLaqBhSHG9pETCGU3f2S2aSDmVjRGth0?=
 =?us-ascii?Q?n98Bk48oc3oF35hFeFpxQfXA7fecxgLSS5ycQ/5iphTwH42plN6y8joizfj/?=
 =?us-ascii?Q?3XQ7DD3t5U27d8S63a4Q9EFccDjBP+BuDnxb6KpezXKMei/NNuZ7zj1MFXz1?=
 =?us-ascii?Q?vnd2R9cVsw/N60DPgkEOzLuAUXMMu8uMUpG9XcQo3iqt+v2GWwjlX9gmJy2z?=
 =?us-ascii?Q?v2VII7n2TdRbCrxF9gdVSAnGobw6bPICS3siLP9fem7SZjHDdMBTCnfFu5RF?=
 =?us-ascii?Q?nWii87v1qlR5COqPA6R/bfYeRh7ZoFgNMaBeQw6rxBLcQP71/Gcb2nd5uZns?=
 =?us-ascii?Q?Q6YYF5QKgoTDS+EvG81DV/5WsMlZnPlZuw+zkUwMg/NYU6pUbYS9XERUt52I?=
 =?us-ascii?Q?rDzVe/8Uf1NivIUFwHBYocCfhXPgeJENBlRMXGHdSjtDjwy+gf8sOZUvA6ue?=
 =?us-ascii?Q?+G9jIoa3HEUOaxT9xD1llasUa5Qq9nVAnkOeuYh+7LjXDsIB6amZ+CV93jJZ?=
 =?us-ascii?Q?CPKLzNTYfLfvk5fTaHD/suUik9o/9oS2/rpomZ5ltOHLI/y1199wl0rvYePP?=
 =?us-ascii?Q?VCFqfXZ6CGw9bXIzcZfFd/M5UiR3HqhD8oqhDB2Iyyp+cNorGgJKB83gO7ka?=
 =?us-ascii?Q?2xSg2F00PTYigKlSF1WZb688KCIiEfUcr1q2foAHYzChhHpm4FzG0RPOYIB/?=
 =?us-ascii?Q?S9lywFMkDtJtPkt3oFuz9mcmFYUKAlSuwhLtmqYycWMPDSiHpK/CEqbMym+m?=
 =?us-ascii?Q?RKUpXZjWHKbbauA7Oavp1hrJ8TwYGZ1R6ieck/Fm9Im49lpoY1boI8FPo3yg?=
 =?us-ascii?Q?T9D1u5SnD1fnB6aeq1478R78otD2zmazrgz9EflXN2oHPbD/tblsO65lFBzs?=
 =?us-ascii?Q?H2yaxr2WN62AmYdDdrzCOAhZlEsws/8AXNzzjcu0Q1W7SR/tCVV/wZtakuke?=
 =?us-ascii?Q?YuNKYJXYt+MOtwNzYubHgFUAK91j8KxmoqjBYKFaDagXOasavTshE8mUAi5l?=
 =?us-ascii?Q?vcZcDpyllRW51nPuydQTZ1NpkQLOu4LvjQxjx22jUKW5NOyRgJigyZSc7G41?=
 =?us-ascii?Q?9EYNWZGvUZrMHN35A8SuHJQ9knQKImVPM9aJh+v/sxlylBGmJKaUvLG0lCYp?=
 =?us-ascii?Q?nUqwkqIeKZUCR5l66+sEEFt0ENOpxjzIwdGgaW3/bzzrX/DIuBr73ZpEQKul?=
 =?us-ascii?Q?w+VM6OmC9FO+myt3RJgHO86zL/Sh0BHY75fKe/HZJORJbzi0v7m+ok3HHCfD?=
 =?us-ascii?Q?bcX2+vJ8QUa5Z8r5zHe3PCJWUVxY7yBfuFa0BdnxCKwZaaN1+F6ewYC5Y5/D?=
 =?us-ascii?Q?G+oxSecGqCmn0I87zoGbzuRDE6M+s241vu6Z9d2GJHTmaLPd9lmuvz1BoZ1Q?=
 =?us-ascii?Q?uTN21yseKCO855HHLuVEwGrII8b3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNwJhUCZJQl7L6DYWcq5HrgRzQDzpOwBaUxCbd9PAaooiTKkog5OdH3wMLuo?=
 =?us-ascii?Q?Kxcyz2k+iZJyIOL1jY8NHm00lMxU/IVHu/kz3AY+Bxf1DynK7OQaAZ6UvWWX?=
 =?us-ascii?Q?0soZUweMakJeqA5UmPdrlk3TkJg/xSByK44vT6y7UdKxcmIGEB5glTmNE0K3?=
 =?us-ascii?Q?a0YoKSgUNKIUM2v0xJiGxtoS2kwV+ARyirrumKn4Zm7d9aobmK717lMzimAv?=
 =?us-ascii?Q?QWbRcxqpm3ODQ6xNa3SMNDEC4Y/VbplBsvE43zQTie1tO09bstdDlI6kDn2c?=
 =?us-ascii?Q?hPp5XL6UqWxCnXBhEIUg2QlDaLs5QuZa0wdCy2Ul/sYeOcPemVJPN1lhKv8L?=
 =?us-ascii?Q?57VNpdU6MA1xTOa7Ooktpz15HMImgGTlGcxv/2sICL4lzPsCt4KASL/kAvDo?=
 =?us-ascii?Q?lck03vOZfpAVM6yD1AbJneRY6TZPDrkwFgJSBbEA4rJgEGO9TksF7Hb/JakL?=
 =?us-ascii?Q?zF8/H3Y+cDv4eao6Mo5p0rjAm3upBnEUsmQVfTdw1dZ3hhKBHbEmIcZL5hUD?=
 =?us-ascii?Q?ut17mFCAa5trPvnv18TVL19BacelyFf/7NYV8tE5J3YLFtgA2CBQ0JxXUH/A?=
 =?us-ascii?Q?KI6ql6MD8zyhk81h2JxZsvK54xLW7P9M4ekUACWguSColol8NLVcE7GT9aoE?=
 =?us-ascii?Q?ssPUMWQ24qFqJvfP8wkYGJkZDJ+YE3xjGtz3+PJ3MnNfDNoNcmB5CuwAyg+h?=
 =?us-ascii?Q?F1U1pP7637v5BzMjSiVPScY3y1uZ6cD1ox0SSyB3IqwCvYLrIh6IKifP9P5z?=
 =?us-ascii?Q?oIKU9Eraw4VcgFB/NWSeQVA51Iq5vhWLOUoXZbyr42Fc8153eMr/VomZkV+n?=
 =?us-ascii?Q?bNjWUSRZwPKXdIhvJTmYu9jEAHyHxx/oaKE9PywyXRj4fcQ4wKot7V30MCqZ?=
 =?us-ascii?Q?jNls1El5EY4Ssc27xQ8nab8/dbUW72eLYBa4O72jpaCkJHvIYK1jw0GXw0ox?=
 =?us-ascii?Q?L/ocuJzSxp3LX+B7UxADz4IbAF53daYtbPWC+zCMH00r9ZK1NQ68mKQp1a/6?=
 =?us-ascii?Q?kwN63z1CSazfXCifctTxtfzl3Sn/+UbvIBR4Y6lVjRuHfqG923j6IQ7T9rPp?=
 =?us-ascii?Q?foGMoBzHBlTucOxHq84BTWUWfU70XIZuqqLU7amAMLjA2qr6OaQPjw7ueHZP?=
 =?us-ascii?Q?ha74DfiML3KKh8gT9o1NoPvE9vTw7HYbSbGoZh1ixXoob++h+zYThlqsKy+b?=
 =?us-ascii?Q?rpKIdwPkkWhFKK1j+n9JVbSJAkIcXDx//jDzKOD1Y7BE53ZF9M/hy+Xt/mC6?=
 =?us-ascii?Q?6oeJHGPVnf3Db+KHPYQKDFftEkYXLEGeVjFIjH/13QaEnMPvkEH4p4yKwEEi?=
 =?us-ascii?Q?ev3n57QWTkhxxck6Br58P+eFTa9P/71TNPlKCGdFH2x0Fwwt6iJkJTrGdwgF?=
 =?us-ascii?Q?hoXyv0pV+PetkQkWlRy1gJTlfIMxL0tjghgm64yUJDFwGWODCAe4cX0FvB0t?=
 =?us-ascii?Q?HH/L0r2Qslw1o0SCf5+6OhW7lZJv4VxZyKwDmDMlfg9B3XrYVvokbsjUqLc7?=
 =?us-ascii?Q?dF4T2ZS+6FFRzBChU+28gpDI2zt9iCSF36qmsCHDSTCigzig0VlE3T/RNN+p?=
 =?us-ascii?Q?8wspuvyOqPvon4cIsCAYZpWXnZgaVUUivS8V4OtF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7206646-b6d1-4f67-d692-08dd2ecd79be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:40.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtiQWG7NozZG5CaXlhXKa4fUr1rWOh6N0JNHUk+ErRkkbe9aWMZMtTO1KijAKiXCXNex+qY3FbKXCNKrKe5YUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Wiliams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2304175..9b587b5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3016,11 +3016,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-- 
git-series 0.9.1

