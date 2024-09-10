Return-Path: <linux-fsdevel+bounces-28973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7E9727E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DADB21EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BBF1553A2;
	Tue, 10 Sep 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oGVL3Kqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33D171671;
	Tue, 10 Sep 2024 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941703; cv=fail; b=CRidpi5+gf3Eg7JEjXZj/4fI5YA8s/DZFTsnrLxm7vUc+2LNq9QP345LB+yGZfMlOhRti6NO9vXIywOAIAkxN4whHxjI3J9upup7Lp/1+ynModsDG/fw7uYJSsUq1AdeEm2IPzQi3RClJd6EpEOXILA+jJqdTGteDA6ktVuIaLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941703; c=relaxed/simple;
	bh=2Mq2sCRCjDKlrt0F8DN7YL3yaumqrdvH+VwCU4xgnOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNh67tvrsQwiLGqzIROus8jGgQDKbjkpPRyIzpLxCKs3L/QvA2bbFs0UZJNZijngyk8bK+vR+I04aIf8IjI0JbBPb9Zb34vDv/Jdd4vgD9bLqiKyEtQ4nm699HHBMwq269L12wdksvIE/zFFPsPtwaRp8MTuYYR5TW3jYOGaYpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oGVL3Kqb; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuushkQwVp05ZUC4gx8qBrAfQcAIY2nnbm+YwJX+qCHjWucVD+PsYRki7T5+sDqRYtZT2pHmZfMsjETMPp85TuB7nZrGKH//RZSuUmTdHwCXGRaEq3aqPjlRwFCRJiPmc+x+rcpkiEYbez4knyaSzb2+i4qXydEIbImNDI6YE7dkBgTC4a+X867mAqdVbVHO4Spp+rYCcHMgQlpWvO3bP+5jGu1ahWpZrAB8B0CSIHpSfEYNPQcDTS+lD1LsOn+1DeoNwTAZfeTqiqkC0uDJSIzLuOKz2nc9tic1NRWJueMkDlxVE8cp4vuonKoG7CDpp3NXtA4ALcJETr9opj3/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDZIA7b0Q/wBPCoHsWPFK3DDgXsBN4K7sD82TYiK/gQ=;
 b=YYqo6yl5YRXnWhAJFNQMW1fBl0zmFcOXYiKhPKOmyR971J9ywiJO9Euao1+S6cUZ9g8nJbrej9HDK+oVMQkUNnUFNVI2oTfxtZ01xdccv7v36ufs2mNJADPIXLr2lUQj8lhIXzYvDZdQxURy7Lr0Y3IuTo8U0bCZ6x1eniBtRdhM3GqhO51zCD1etI6WUZUc4c6SKZgzy0yAq452u5xBU8foDOdCw58wt6xhNCuQ31+i/flcjicO0U1RRYtYMEsepvr9HaEuDaLYQzJkmoMa7fMCTxkqrnBQhGkRlOUxXcVwNW4C3/csjyjunM3Ip03KWeWEIjXjRMfgA89A5a72Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDZIA7b0Q/wBPCoHsWPFK3DDgXsBN4K7sD82TYiK/gQ=;
 b=oGVL3KqbHRBzkHqAagqE2MDwSCwPp9ojvkwOzdxRFdPoBnxE5p33/RnAxEsLe1HdkVraPG4q7Pe0GlfwgH6ouvCYRdaIh4tUEcFGEsaLH9Mm4HepFkHqp4m4uxi/4uaZJkrhGk584wRSnR9uwi4GYKL1BkvjY60N6KEBw5gmfWd+bG6LOez3roNcMqo726eervczdgRcD8eaLUzWBUB2IoAqaGrgBYF1/Dr0586ZDfYtTaYAi/iMnsDqF1HDO8IEib8PzigBQg/3Zbgv5PPC4Fh85ujAZqB0wsUZp1BrpkbjVTyXjEQUTjJrt/TYkL521kpmQkFOExd8yBiAz+v/pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:14:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:14:58 +0000
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
	david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 01/12] mm/gup.c: Remove redundant check for PCI P2PDMA page
Date: Tue, 10 Sep 2024 14:14:26 +1000
Message-ID: <2ebba7a606ef78084d6c8869dc18580c56de810f.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0052.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: fe089c1d-9434-4029-bdbb-08dcd14f21f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N691mV30cr5XvSOYTZoHp7GOUkaNqYT2MHhBHrOYzgj/3b+/pZo+CbLkpH2c?=
 =?us-ascii?Q?diRcw/UCnlRv68SVYV/EenIi5cdiL7IcjVw9YNxdULQ7KUK0VC6tem1Y1emT?=
 =?us-ascii?Q?KrvLAB8tdDwIMAJv1ShwGCZQFKPrmNuzjq30JGXfeIs2oC+nCqJTRwxQtm23?=
 =?us-ascii?Q?741tAMS7bjgnluNjmwdxHB+vv3DzRm2PK2MSssBIIVFMlEJDiB5IO24EZdvT?=
 =?us-ascii?Q?8Ry48VranA2cbjLkggDRTfwWF8SjA4sWeHDUr26HlANbUM1ttN6ZA8O79170?=
 =?us-ascii?Q?6xtyl880H5LY7olt58/DuOSEX78CYTYZlZg6REGYb2MGO20WPE/ZIjB/ZU2k?=
 =?us-ascii?Q?RsuCfxb1da+3WY1f7NYTCfajQeQek+wWVIolmtnhIbvQcNvZnwEpMVbLRP+O?=
 =?us-ascii?Q?k6WemDLIqnSujFeme7ywBpkgNzk09EBclgTFiAOrQBSNZ4x83qcHjW8iQ4Uu?=
 =?us-ascii?Q?9VeYrI8khwmsidnKNqO290CZLbCDcx2zUKtYBmAhGoKMLxN0ts1X6uebCmvi?=
 =?us-ascii?Q?7Z8A06sOkePHCn4nN/GY8Cb9mB3/kEDtFaMZjRDQUbtUrrkF9B6zAJwSzZG7?=
 =?us-ascii?Q?zKlcAsZI9gzJ0++pv72tMsdFNcDVQ33W06vRqwHKWTtofQ6M61J9TRWORJa2?=
 =?us-ascii?Q?bOHtVkZm87XAGrGACXY8NXdspZiSkoS88OCAJZUQv8w8xx6YN2AAe8K63/ze?=
 =?us-ascii?Q?5QPLVoPpNsUaaXkZqSkmHOrRgLQHrjPji/1KfuxDsmsPeoGgdSNF++hhMfHB?=
 =?us-ascii?Q?RXRC0xp2jVpGhXbgVTf9RoPY1ONbgI6k1XHJ91wDzAtIdUUgCahotoltHfh9?=
 =?us-ascii?Q?l8XZAtTrs8NRuOWqTuGysM8Tere/FGDV6Z4uszwWwX2Uwxa6F+WVskLpu9hc?=
 =?us-ascii?Q?I9NH95/3y6pPNJk/GVNFvQKOWqhgXkrJXuJtfy9CwwzqDlpzTqjCIeH3714V?=
 =?us-ascii?Q?m04aF9n5GPSugSGrnM57oKf8XDeDnamAemvu6vYeCQruWNHU9IjfGV0AOpxa?=
 =?us-ascii?Q?1XTJqQ9fcsK8c8K7w0FqHciL7saDezhV3t1UDHo4e8TkjFe7KfPCuSrKgGuC?=
 =?us-ascii?Q?37/jY4+5QFA5fTIQOpUUm5wF9S1RNHZFXkb8yhLXDBBzjtJe26ARKj5bwHUF?=
 =?us-ascii?Q?bEyzA6IpKSjoe5r8KDujmzgpYNOqVS1vXmglDF7nRxfrMEFLMqyzUHeiM/cJ?=
 =?us-ascii?Q?FLYaBoEJezyd79ucLJLswDag4E77jn1ZwkWcrji5KzxiLSFOjLNBPoO2EGMt?=
 =?us-ascii?Q?RJSeeM91/OuHvXd6SRKsyLEpHt8Nx1V4cdIl9uX18O6lIhZCman+YEXCFPJe?=
 =?us-ascii?Q?r2KaVSvMHWxC+1yDWVOR5Uw1Y2UGkycwFvVBtIuZ5TH4SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPLav8Pmg9cmH7rrfcIvbv7YDogC3zthIrBQyT3eVcVGlJkRDzDLPsFy41Kw?=
 =?us-ascii?Q?VWGDhZid8mbHYKZolIliprSqVo7fSFfhipS9k6+Q9scrRi8+9+e6YkCR+V0t?=
 =?us-ascii?Q?dA5hatrDfk264sTpNeQz8Kpt7F8vImKsuly+z8ExKhZfvMiA5KZKD6tIYg8k?=
 =?us-ascii?Q?7DlnCl6na4VXFtU7IdyJl1pRCrgVBWdns7AhoBSVY7+w3b4t5e0T3+bp1X7H?=
 =?us-ascii?Q?e44NC0prVv+BuUx0gaAcIlIgZyaVt55R6tZMwTwByk/iFnYs04VYY6T+mMW/?=
 =?us-ascii?Q?F2OCD0Dlj/8kzdN+OHQK7EdhOvYV8oyVKuIV9oxAO5kkYokgV/JIr7qzqs4n?=
 =?us-ascii?Q?7mzgwog3fP15Hip/I5edLFoMK2A3IqixsyxCfs4s8F+Q+P4YtCdqdbswh02J?=
 =?us-ascii?Q?mI0ijcZnb2QH4paPHYDkfqpkLUfYQvSVYxTsUnUecdGfl3QanQef5/QYRcIn?=
 =?us-ascii?Q?CbpJAspwM/y9TW6pzToxOGVGGtOc/Gz6SiA8auUdtQjfoocToa6SoRJ+N/W+?=
 =?us-ascii?Q?RDp4v4ucECma7NqrNTW+m/kCOvnExs5NzC0QbE8SaXWKc+9OnvhxsZpfB1bN?=
 =?us-ascii?Q?STuXfxANB5eeRBwe94bVwUs7eoC5HouwloUi7cV5x4vfuO/bhClhfVHPpHul?=
 =?us-ascii?Q?mY2W1JFghLg/dobKG4tIMyTwz04kxePyWbuFhFwlBPXguEq7P8h4DHfjHMdg?=
 =?us-ascii?Q?tfaVzr4X7tql87HvurkhHhCM7jZCoAj/Msr/JlfJuRvV+/wErxfbxU07FXXQ?=
 =?us-ascii?Q?UYWNUEDuk39XIWjmw/q4cOo9hFLZ7ZOezUd3+Mh7JiljZwFDo6WBNgKeqdJX?=
 =?us-ascii?Q?wg9459SID/vFQSiZpw6E3K7HNKyF9nnQ3cra8bIFNS5dPZUSuSjeMrinWm0/?=
 =?us-ascii?Q?GV8OeqDcCdcIDY9qm+EyanFhGUmODftcCcF56P1t0GI/IAlLtVY7ik34qlQD?=
 =?us-ascii?Q?nINGzn7yaIYycmtjmToB9IFxyTMfPddWZ5tHeE9IPDwAGLKyqItBXa24xlMM?=
 =?us-ascii?Q?RLmgId0vQ0njPkQziiqIDFx+J5k/XBsp+jQvnapaehxddUyAqQ821ufY1B5h?=
 =?us-ascii?Q?yf2bhpWsiVfzkccMf6qG4UOzE/C/D9dS+gjr0oEyEbnQRNCLvRm+JJmzDu0l?=
 =?us-ascii?Q?6rPJMxzaT942j1l0zGhHsCuzn7ghurl2tqY0vYGZdSrvZJkGqksBeqBo/YaG?=
 =?us-ascii?Q?LFCe+MyBd0xsrSV3ZCCVTBFlfKKIuktMq3anmn2jJNSK8eVr+iPPwwuA4xE/?=
 =?us-ascii?Q?wgf0AAVncKfqXMOwfS47NqCzxDiY3eSI6Glrz/sxe6eF+w9k71hJQSItgwPH?=
 =?us-ascii?Q?g5JC3FfszV8ulYOkq7RTuWqMe6X75KpHEBEiBkmDgoOvvJm5E5Lh0smxRjeR?=
 =?us-ascii?Q?1KWdTkSwPXU7yhTjG5k5R8voWLuKCA5J0Xm/MdO3MzJy56MYrVSA/fqk2BcN?=
 =?us-ascii?Q?YEj/6IHGVJHFQjPvxQKLWqA0nn2y3zsseXEyVMBkz4LPHDRMzE35X9oG89qp?=
 =?us-ascii?Q?TiCC5+ZCbB6gurppWEnBw0aXGBp64g9eSg2MEFlSeMcQuLWAQFxOwgRnOu+q?=
 =?us-ascii?Q?SPRSP5Dzzg3IsxTPgP4DCS8vz3VFt0hhfBK0tfxc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe089c1d-9434-4029-bdbb-08dcd14f21f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:14:58.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loSBcQCmmp0Q5iqu6vRQ+5oaZmLPN0iHid/T1Xax2S7M7u9o2eR9Rf3+c93OJjDjfYHBA791sy3gRPGMNCX95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d19884e..5d2fc9a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2954,11 +2954,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
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

