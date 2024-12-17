Return-Path: <linux-fsdevel+bounces-37588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857139F425D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A66F1884CBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB241E0E0D;
	Tue, 17 Dec 2024 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sRHq0yrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1721E009D;
	Tue, 17 Dec 2024 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412493; cv=fail; b=d2Lg1Yi8pukFikjSg/rAAZFsyiwuQhmKV71zCSmOz7MfH4lq79AcMPonHw1Y4CCsMUiDUm7PSiWo2EP/tScF6uPiX2V873Ff5XaXx88y2mpvMRfa3RmMK0H5e+R0fPoFrYDQMEO455YCvE5hRqXA59H870r+huvA5raOzRKgY1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412493; c=relaxed/simple;
	bh=Qo6JqW62GOVdJl4feJ2FrrqF/BpPFcAJh/nL4RPVPj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipu5Y2OB3HiCg+PSD+16fPEnhZXPVhS7CsuBnAgoirxxZpKkBkswfazneKaVqi1AL/rAJxk/TJc6gQve5TPESyqHilXMCKYJEHa901YXLacFNGKMKZdHshp1VoJvcbOxmclawGikCR8bx+sYhsECGWBwfWd2FuUsUybJgaeBumo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sRHq0yrh; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct5OYc3bYyImuqdqXXLpsV02s6AxWIxgPg70Wm4FZG1+qXuUnAanHqG2Deb+X1z3RJ82EecAFaT03yFtTne7ZqpDHla0rgGzs162wj6dHnFnnOk662vKxk8JL8UY1h+eroPlIGG/z9HboUslORLVMVbta3a3HVbWqcljzZsnL+W960Gh0rpY8gNTGp/zKJPTDTjRBKOtkG7EBvJd+0PkCjauF/+H5Z4WsaRckcEbiq5oHTX1712ZwK7JDzKpTpnU+1HnD8/2ZM/hVrSYppb+cnV0w/aItlcXPPy7H8xQa3xyMiXkGUpiHFKApdW7zJPHV1ahGmZgLYpRUCtBwKZzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d8k0n8RHHqQFTOAVPp2FWmERdGB9c/dPWGRz1x4E+I=;
 b=EnLO31qMIFcgUzICuXZS/3uFnMM5NoyhRnRPSKP88oTPNZUZawCaKnja3iCCTdKuGUDHrp/L0nrx05HvI3tdZTOh1FDccudNMGNaRbxvIEnL9GwT78dxNkIdR9giIL7VHGM3FPQsuqKrAfyAx49mfbCJyg1f8t0AAM4YhYFCsXHOzi1nc2IMIqKW2893K5nytpxIMDzV+UqOGWwux37iwRoGRCTW0EQNbIF7ud2nrqDcFLBces1yhmnJkL7afKkuR6YsBY8t5uJadT5pyL/HWWWb8c0Q0d2sSnGKmp4e7wlto4ts36kAuCA/rwNBK0iEd7xCWRxYLvlB0ZhU51t/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d8k0n8RHHqQFTOAVPp2FWmERdGB9c/dPWGRz1x4E+I=;
 b=sRHq0yrhIgsNSsMfKPpZBpqvwRTKGVLDC0VNcgc3mzePufdgN1HZl79eGk/GS7OpaIR2qxVH27tshHK4b+yOtF10DpSpdmIbZEkhNXmeAhTWJymKyh9gCsTx1AA04Hy8szRsOeMs4sFy1tMZouLSUMrWQ3oC6oFxcZqC2z6jtlWCwcRRlgy8WYyKAc+AcEgEqGtXx3l2dQU/j8g6l1WRxW6sOza7UguHbxa7GXe6JoOJrxEq+24yuKeY5YYNEO+NayrlYt5Vyr2t7z2YslsXd8c5o8vrXLFsXpBPur7wD9fmEHDYb4lrMht4jjJda3aVpkWx0tb3rfNjQSSx7fVrAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:49 +0000
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
Subject: [PATCH v4 14/25] rmap: Add support for PUD sized mappings to rmap
Date: Tue, 17 Dec 2024 16:12:57 +1100
Message-ID: <7f739c9e9f0a25cafb76a482e31e632c8f72102e.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0044.ausprd01.prod.outlook.com
 (2603:10c6:10:4::32) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: c64d6aca-46d6-4747-9005-08dd1e59bac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKD1HlBqSFtPHZEyhZBcDJJ3th3zP7/3ZWJV6//EpaZXa0ZCaZlb5shiTy5x?=
 =?us-ascii?Q?SXTHSvH5eaNMg1zWSVT3CzWvfNja/4tPJdiHdHFwgoIXTo/7oI9wVHs3w511?=
 =?us-ascii?Q?9yyRQh9bv4JJiaMj5BTnqdd5xIM6SxndalmltFJ6GZ0MAO4s2/ScPwA8uzcw?=
 =?us-ascii?Q?MkOV39N5IyOhtuh2mW525MKr/uUmlQngOVKAve9MQT15v1mK+T45RN7U9qgr?=
 =?us-ascii?Q?5BVrCs6D3U/HgS/+FjtRvrtdK+o8uGMPh1iv8QvWXTo3+ufjt8hhlzuK3ZR4?=
 =?us-ascii?Q?ZderDRCxg4qr3TrDIrTakn4eAGgl8WHPpZqwsjKaYJLE29GdlFustqGF9xwS?=
 =?us-ascii?Q?gm1LyVPM6JBexZDKM1fSA0EUY7HjdlXLtrAJwgkNK1nB3q0Fy7IRnbb122pz?=
 =?us-ascii?Q?RDTBXzfDqSxugK7p6hp0SFZcuGVOz1GCs+6wo3TEHggI446ozZzP/PKnL0Xi?=
 =?us-ascii?Q?pr0RieLt8LuERG30WAkEPokTydvJ+zxI005rDUWSqZ+KPFuMrYVz/fWBghlL?=
 =?us-ascii?Q?W9YnGFBhjqnj4pkh2stRsZaQ298MUCIZHOCE2Gx2mhe6TSrvo09JG1URuHw5?=
 =?us-ascii?Q?SDYyfDsFaXq58Y+Bf2RyRu+geNszkvwWzQR923NaMbcE2AuUf8SPnPZB7aNi?=
 =?us-ascii?Q?s2udSdbbepHP1mbZ+YA8SD7Iq1tCZzQ95rvPPoFZv13BHrZcNHN/Oj5xMT5k?=
 =?us-ascii?Q?uwsQ5WK3OAOazliFcuccEQufn5f4x7emMNy5dJnHAF72/VIVuwJWiMmKZvwJ?=
 =?us-ascii?Q?33l2RiceJSsPE6tlS1k+Yc8pdLYGWMBNO6EWwAar+F7KW7Ztr3okazTDAeQb?=
 =?us-ascii?Q?gknN0Jf//XLxvIFrlFTWWyAbCEzLnK4eRjwSt/SHvxTX5oXZUaMxy6zyaCL/?=
 =?us-ascii?Q?enQPx7B1As0XI63td71w1AW6WPruyOG13mBF5rlNwEdqL87YICpis9OIQS+A?=
 =?us-ascii?Q?dvjIbu2YglL3ivKX15YN/Wqomd93b6FW/rzOLZBHnoEHDaxTySuyZFKjP5p8?=
 =?us-ascii?Q?GsYh4frFpO95EF/bAJr0ViGqb9vuA9uLzKCv4mfDCKCneocBYGTcwBWFWxLU?=
 =?us-ascii?Q?OD8/DpVH6pR3CTp3lcVk2MwFwjPPbBOScvazkQ00cgUESIZe0WidqzoPQiET?=
 =?us-ascii?Q?m+fPivedtsecAbYfBTtBf7KtQQSR7RjJ6wSlN1rWV75ykAO6xnTajWYqYOH7?=
 =?us-ascii?Q?Gz309d9Mcee1nBxxQvnVh9hnpZlLyizIRAewymwFu9fRK7YSAXp2DqTju2pj?=
 =?us-ascii?Q?M/x/Oc7kzm7tltnPI4TdSsDzp7vYuJtQISvQ/piYIcC+NV3A0wh0v/hu1CiT?=
 =?us-ascii?Q?Q1ZJDBPkF3MfOUi/9M4XZi42R0Gpk07f1OzsC94LZ6u2698XxQNFCoSVdP/+?=
 =?us-ascii?Q?gYswuldkOdTBBlf+Zdxu5qUpC/3c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ap2TATHGi17x3GWHrXb7yHLTIqzFkzsGiHQh82VYM8Fb0b3ttcFiHcDs8Z7?=
 =?us-ascii?Q?63qb9VKepqJ5LxQxRqTWa9tGBzZraEX1ITfnjPxkDFvV7mh70a3bb6rW5RQP?=
 =?us-ascii?Q?Fj0BZ+0zJriYNbz6fAZg8uVhRkS+moOh06NdHs0xY0wwCWansa5IbmoJksPX?=
 =?us-ascii?Q?wDu/99lDiyVj0PcVYNKcJKKZPRdJitxdATpPK6ygiFJj/UhcnaMOgVKVXh4l?=
 =?us-ascii?Q?L6Qgw+CirTwd4bDybMPz8NMpBgfvI/veUHNSnLTkIWDekVUzz1rRvq6bk3p5?=
 =?us-ascii?Q?RNuyzTU36FH+8VJC39KgG5a4Wjf6glhcWFI316JRV2sZuKRkiPdQiEuuYJtP?=
 =?us-ascii?Q?vfFNkbWim6T6Gqu/UgHIi+k/NiYRr4EGtpX/G+YgrbRdbF9x0ZoenSFeolpU?=
 =?us-ascii?Q?FxPFxPKlyEPQ8VeQHP9fSZzim8HZDRwWOIttPRBFj1vCgYQdhqzyzbrg7P8v?=
 =?us-ascii?Q?Hk+jYd40e9KV0Ocpk8UoNJiLrXI/tm05QSjjf2TASEl9wFIzRY/hhXoCVjp7?=
 =?us-ascii?Q?l9Ph9FDDjATy2nCCazMCK2zDn7shHKYVYFzLzCUXaEwEZU8quj3azpy9x69N?=
 =?us-ascii?Q?OqCfPAJWhIt17BOM+QgdSErieguwehUR8bKgpwWpvd9gpIKLSsbarERNbne7?=
 =?us-ascii?Q?Q9cawR7mtgRBQEIt6aU+J2X6URGTHwUzqaTk+5aUD9ehH0msUWBqKIMzfR6d?=
 =?us-ascii?Q?sZ6JDrtmcEyhgZdM23rMumzoz5vE991nZhvJHCx3pf6Mfz50Og6INGLf4QdB?=
 =?us-ascii?Q?wAOtP9EpltfLpXwLvcnI/cJeFG+D7hn/RYN9p4JN3iNaBGphf8vHdiS+11Q4?=
 =?us-ascii?Q?NeV9k/a/YMPU5dhhSao1x+FUmymgfSAs2rr2nRObR6+tf+94d8J2ziWAA63Q?=
 =?us-ascii?Q?ZsLn6GrufVQs71RCwrdv0wgJRFrRxUxv1SRiznRpUJrfDR2aDn4Eswumva35?=
 =?us-ascii?Q?DF9jN6eYys+uDpe/Of0u2V72vVAHXxIHgZ151H5VX2b8ANa6ceS/i+7GeN+1?=
 =?us-ascii?Q?IdDHe+aNtR3Kb+VFpZAKKmUpkpmxvWZpUAyooE/ByTE2sSq3wzFd0VQdbccX?=
 =?us-ascii?Q?/GmU0raQXXCwsXkLNox5qRIfXEuOfLI73yc0NgoTshTuS52K2kNsN14ZgBWi?=
 =?us-ascii?Q?b9sjjflsVSk1bPvf+s87bBerIaDM/gwW1NG0x816YxU1oMWBVQoX5jN80wir?=
 =?us-ascii?Q?oPqZ6VALlUrfIaVF1Hjz2PW4gQCxvZCbb4NsHpyYqYrioYVdK5HeD3tiZ4vA?=
 =?us-ascii?Q?Lpt7sZq91DNz1s1KGhDMto4SURpYI2FaNWwn2/C9hU8rWTiHiyBz5/7Ui8Fx?=
 =?us-ascii?Q?wc6l6bN4kLb8AijabqrtF7w00nhoUGsJbXSVKdxEmpVm/3f5lvf+QL2hdLPi?=
 =?us-ascii?Q?kaclRIiviHP4N82xMXHYB3pojV00ScYY0BbTH23OHA6LD8jAm0bKCIgDPPIn?=
 =?us-ascii?Q?JpIURyhkdedeBcndwfv4Qf6+srNvwYSvVv74GZLjYdg3mAvl7OTKYH6v5GpZ?=
 =?us-ascii?Q?hU+rLiCOKZ+dqlTiNhmovLbOy+eV2pC9wD7jGJju1wuFptcoF2oXdBPjGykr?=
 =?us-ascii?Q?zYrCRA5+H1xu6g09H5hgT7jhSJtggXRNQ/VLExmO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64d6aca-46d6-4747-9005-08dd1e59bac1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:49.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKohN67e3H/g180R8p2mw0bIlcAzt0522K3IHejIFMwCmrHXJiEZzXl4jjJWRBI0nZqCJlsY/DYB3PgXspj+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

The rmap doesn't currently support adding a PUD mapping of a
folio. This patch adds support for entire PUD mappings of folios,
primarily to allow for more standard refcounting of device DAX
folios. Currently DAX is the only user of this and it doesn't require
support for partially mapped PUD-sized folios so we don't support for
that for now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

David - Thanks for your previous comments, I'm less familiar with the
rmap code so I would appreciate you taking another look. In particular
I haven't added a stat for PUD mapped folios as it seemed like
overkill for just the device DAX case but let me know if you think
otherwise.

Changes for v4:

 - New for v4, split out rmap changes as suggested by David.
---
 include/linux/rmap.h | 15 ++++++++++++-
 mm/rmap.c            | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a040..7043914 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(const struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Assume that we are creating * a single "entire" mapping of the
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
diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4e..39d0439 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1203,6 +1203,11 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		}
 		atomic_inc(&folio->_large_mapcount);
 		break;
+	case RMAP_LEVEL_PUD:
+		/* We only support entire mappings of PUD sized folios in rmap */
+		atomic_inc(&folio->_entire_mapcount);
+		atomic_inc(&folio->_large_mapcount);
+		break;
 	}
 	return nr;
 }
@@ -1338,6 +1343,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
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
@@ -1531,6 +1543,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
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
@@ -1578,6 +1610,10 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 
 		partially_mapped = nr && nr < nr_pmdmapped;
 		break;
+	case RMAP_LEVEL_PUD:
+		atomic_dec(&folio->_large_mapcount);
+		atomic_dec(&folio->_entire_mapcount);
+		break;
 	}
 
 	/*
@@ -1640,6 +1676,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
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

