Return-Path: <linux-fsdevel+bounces-28976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B009727FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271DB1F24DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F5171658;
	Tue, 10 Sep 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMc6RK/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9C18C32E;
	Tue, 10 Sep 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941719; cv=fail; b=aszw6tUQt0+6LFWgpQ0kR9MPu3+F6/r0r/bQS9Ph5Q1NHTtPVnbrnoYf5ScGX++HGG85pyWG6409fve0/+9iXqAAmOkYG3oQLAhMcipf8LsExRKpLLc3uXWGllnOWGiPjjUuIcLpATiDCp+TfZgyjDMff6NZOd3AfIdTVWVx6XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941719; c=relaxed/simple;
	bh=63HHAE7U8KheeCI16daaZ8HaV/4dWktvA5XX4WpBirg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mq8r2iAUWOsoqhozk9VG8vSefGl9oKNZOdTpUVhT0wKln3M/sPIuqcW1jlmDHEonB/zTCNzKSbgzluoeKVC2JwPYq9O4ohZY675WQ6k5R/FTEL22qWsAcH8/iO7T0DQZrGB0wIwe39SKfIHXGoLRmsHIhJ3UYUhpHG1ajhYti1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMc6RK/5; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0s5HjgiXJovpJ1+1cWjpMmFdiawikYgZCOBGVFXQyYXeHzFFDGVJ1RsVzU8x4WBqz9s4XHCxFoUdg0VwzKkyeoj4Whg1HodxYI17xsR6lmzAz3vUQ8+aEZ8ran2BjnLbPVYdFAllbGUmUPCzv9hJs/4RgObCUIgDnUJaW6E6SJjEng1qitXjYkijpWniZqievDOMWCz1HJxhgAxXyDPs8bzQOUMuLg5Yuj7db8gx1DCtPo+QzCAL0/fgrSHB9ZTxScSZl5vRMdbShFtJKSrIqPGdy/4lWQPpmtYkhakcdFiVhZ6ktPonmUwFrQ+zUbugXz0BmKj2q5cq26VEnprEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEsOjpdhx2gPdJTwDK+5GbbARYUEApLZebd7uxMRR9Q=;
 b=m5zKAEoIS2KWAcYnY3N+Pdp3astcqtr4Xfh4Y5fdCErztd+cbyFEsNKNdSu9fEPkUC2coxC2EpGQj9N9XMLrsKhE9TNY8L8pzPlZbsJ09lR21M2YSerLcqRYmwc9mZ94K6MpxnunA0hVYcUDmMyCrVLMN8vFdO4JDAZU7+btT1tNNJplcsCrXOJyvfRRi4OSTR1QWJxafnTP5NMTe8vlosuKUVIxu2LP3kogzzpJMLaqk3W6DAlNLVuIdTyO0/CbH/T7VL0cDB+UGtmbrPPveTVIu98FJCvkVYBswO5E5PMf0hpe83ynfVUcypm5mN3latHRkJB7SmHarEb/To7mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEsOjpdhx2gPdJTwDK+5GbbARYUEApLZebd7uxMRR9Q=;
 b=PMc6RK/5gmiewEjbZkjkJ+e8yjpTAIx5yvv+7RvBbejaQWXzq+BPEPcUhppMLZ1uQ5bsCu5wYn1aBG9bcm1r5jR804qWOCPWYdMf9jp+4vp0Cg/X1HNBUzYLynSZ2dRPJRavH4gjTNluKpHkPIek0OpLfKycbN3ODDvN4c8ecLeq41/2dvi/I4H5CK57FLHR2bYJkVFtTOX6H6URZX0PvfdpJxCS5CJ6qCk8iY84SYdKzhQiufazBaEeFebgEGkz4hyyEx2uAiJkUyw7aDgdBbmJKx3AWRLpU0hdqxoRLisdAv23GjEGE3fxi6S3Rj2kYJh0FRqGI8cdq5gdvbjzEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:15:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:13 +0000
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
Subject: [PATCH 04/12] mm: Allow compound zone device pages
Date: Tue, 10 Sep 2024 14:14:29 +1000
Message-ID: <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0015.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb2e5a1-eb85-4f45-ea92-08dcd14f2b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uoFnlTqPCRafGcsU3FqgEABbN5Uqrf8Hfyolk3n1xFlonzTwRyH92Eey9N+D?=
 =?us-ascii?Q?TObprvKP92pl/ghpUQ5o87Cac3jdXgOwTdk68spF2ijf6J53ftF40kr/DaHn?=
 =?us-ascii?Q?DLozH+O6dlujMj+eyADjXw25Y6GeYnRzxMDXQLHc2iWyhzrPBJ2iTAa/hc+i?=
 =?us-ascii?Q?uSoKj9HWl6Zy6fZ8ZMD63oNkzgXL6NXA2afKIiPB+Qqw+p05e4RFcIpfUw5p?=
 =?us-ascii?Q?0gY9zOImbYTgxS2t98ScXHOT+50pPDIOZidYa0JXR3rfOMUOfSjCi2eBtmpQ?=
 =?us-ascii?Q?WZKfbGs5R5Up4Ehhhb06qCXTPcPKtj9TpUfOG1aLTi6XrmlWIi5Euu0NurN+?=
 =?us-ascii?Q?OtecMfRhOuIjtT9jqgSOZ7ufXkt3VR0/iIOK13TWMsRwE9goifOmGGATAyfo?=
 =?us-ascii?Q?bOMgyJI6pBawpOLiqR/5eYueXNQpENCONyigDqsVebw4274rZKMBDwntuQVN?=
 =?us-ascii?Q?oypXm4Z1iEi6c8fmY+XZuE9tlqK3iKfIb6rgh3tf5FXxeQcEPL3Dg+/+DHIA?=
 =?us-ascii?Q?J6OG6WbQn2q6cKKfrO3knwJ+v088CCNGnuB1H4jUrlGZSmUjyYciDLCR3Anm?=
 =?us-ascii?Q?AG3TCmPEP/TGopTQKmCpnls2NJvDuBsmC6qYoYr9JpemTsjuCPgQWiYH/4UH?=
 =?us-ascii?Q?ZJERQynh8IRTfGihrlzBNmhwfH0w/3JkUrc8hCIsw/YLXGmncxkAT2HSqlSF?=
 =?us-ascii?Q?exw3QSBGZcfDbptYE/xRmSz3kAwJX+SRAdUvhDQf45/PE1N3Aei4Ic5li+Yp?=
 =?us-ascii?Q?wj+91UMDH4+DO7AOLoOILZ0ghiEbbXspV42Bzz9VdQI4mdwQnibz1v/kcGE3?=
 =?us-ascii?Q?r2hghrQm12se6h/v8f/WAxOA5S/2+FHaTt/TZyI1T7HoK0baqHx3qOmv1l87?=
 =?us-ascii?Q?rpORvCm5Bv9J1YLY8P3ULXggi54BXboZpMfBtHgmkjTIThy+2iQ0vc/OylHG?=
 =?us-ascii?Q?IO+zNAk79DQxuZXOwumUdgA1OD8eY4/2dUouhr8us/VaVV/dbL/jjIvIUqRk?=
 =?us-ascii?Q?IuLW3Acn6F4gHv5RYp4lYobXLZGmJih1arTYhLOLUY3C4EGrUFkXJUGTFY0F?=
 =?us-ascii?Q?+usyM1BY/aJbueT6YFJp8D/pO/8xKK35g8ei2y2caxGSpqAIHFNj2CVFISMi?=
 =?us-ascii?Q?MuZPfhZ2pdCTrHOGkgmkLrqXFCPHAVx/sJCEVpTwIYqUm3ldHnBcNLFsCXI4?=
 =?us-ascii?Q?aGsEBN2s92ep+GJyk5surKLK3hVKlapjwBUK9iURgnY8FZSeybxli1J9ZTpy?=
 =?us-ascii?Q?8Han/PNK8wRoYj/3GRrLkvEAeLiOMCb0euVnbo21kR7TT+MghiU1CQWfRtsW?=
 =?us-ascii?Q?70+jIXVAWkXfpnDcxOlaYmhlaKFrlQIlxKDCDmYZDDUCxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kBXV69qqtHhZalRdv1aKk3DNGZAlbMYSXVxcu3EYI/s5XkjBxgTzTnWzSmkk?=
 =?us-ascii?Q?xfdKQ1l85w7aO4brH7Ppoxk3iRpsvA2orPpQ5hjhGIEzsXUvXtiPrELcYBcu?=
 =?us-ascii?Q?Kkm04Fv0MuxoEXlPWbtpOWiWVPCcJ5D7G5BwD4PftvCwDg6sG68RqAHPO2Eg?=
 =?us-ascii?Q?qajPgMS2IjDeSMdDlYV8snBWD+9yIsOMf3yi0zEk+A222ejepWhn6cKlfNlA?=
 =?us-ascii?Q?jWUeO8RXy/lXWzuaIFKmyrXcF8JET7wCf7xVvNDPHpgsIaLo1xSFvsAYZGH9?=
 =?us-ascii?Q?A20toO6i4oCrKp4M5aWc6fi+IMxqWJhLL/hYSXQm/eLID301KOA4Mixg7pp/?=
 =?us-ascii?Q?IjDJHMQ0hMV5oC98DgzpwT/exZdEajeimwGU9AcIVjOSq1VAZL3RImOrrxCt?=
 =?us-ascii?Q?ca2ymWxOS7KeV6sXWcCqPAXC90712qf/ZrTh8DzcnnWxrCKShHc/Ov+nK2Li?=
 =?us-ascii?Q?gDp01Fekh8Mr4gCLZ04idufFOqyN/CeCmnEYxFaRwYoT0vS4lfpsGe0LJA4+?=
 =?us-ascii?Q?7YiECDIcOAjlXjLTrKs49NGzXDF6du+2PO+aUywG4JfFikULD5ojnYo8jXMK?=
 =?us-ascii?Q?4a54rmwv/gQBZUaIYNUlnAiIJ5ED2G1xV9bUgwJMJR+1gdpAfbfJDq/aL3vY?=
 =?us-ascii?Q?Sb9o4q/uRwx5GB1NeOLMkZSI9fl7Prtl4fLvU7JGmXYrxldQs3HOqd0HAeI0?=
 =?us-ascii?Q?lcKXuO56vdxqXrNfhSWLw0c+j9YtcJeySewibVCWTtAInaHxB5dot+OzXiTm?=
 =?us-ascii?Q?DofXU6TplMEBZPTCQnvsWEXvKshEiffakujvlZAtbR2XhHszZTuC/ksZ6aGq?=
 =?us-ascii?Q?c4u0qnuyiVO8cSm2R74hAe+7qJRPxuiM4QUDKoKnjHL/Gk5SfZAAbx024HNA?=
 =?us-ascii?Q?y2E2/736TqdSIv/wsLaTkeYB+IxWWTdrAFDDvUUJKentZ2Eh5s0J0qqAKoh/?=
 =?us-ascii?Q?VVco4TSbm/oqApdVZo9QEObnvAR0kfUkP/vEVFpVPfyoPFufaKDTAqTwGiFF?=
 =?us-ascii?Q?JDaLIOrURijdFJMNWVbesIHrshCLr6UPU3CL7RDquO8/ZZ/BF8lo6/E2ZsQk?=
 =?us-ascii?Q?qJnfqHI27MslELd2/9lw2ZBKAARUNcVpr65jtkR0P0PzGiSTPaxP8AfiXZ1d?=
 =?us-ascii?Q?ZerOpgyTCnWHbUrqPvm7Mq+PfzK3D/fg5uhA9QaCyLSbQiUNU+V9EsS/4cq0?=
 =?us-ascii?Q?oZgIPYROp4gCS7A9V9a/9GwilRPvcWECYVADcIJVENa5M/Zue2NpZAd4ChM/?=
 =?us-ascii?Q?y/8RjO8K8ROaUYiVBzo7i1FeTjdpOgs/ctKpmW90NpvwluPlHPi2lPpV1A/h?=
 =?us-ascii?Q?3uH1qNN3KXv0yXTVIJpJ8n6eefT59y1sumeUkZScKO9Yi4lEwEVj3PRzyUnY?=
 =?us-ascii?Q?HpxhN3U8QkWik6C2Noz3R2JVjYpQADAqSQ4gK3KIeZXQRYNh/jpIq0bsqahn?=
 =?us-ascii?Q?/NJ5kJqPKMimkbN9C1SVeNAbyTLbJVtVgoMElTjsCoG9vScEhCBXkWrBss/t?=
 =?us-ascii?Q?JCQMtw11rFis82ygqJnfZPnz8l+J5FPT8UJFdCgLv3r3YsVJIpK1u9I2R3Tx?=
 =?us-ascii?Q?I6NJeQYV1XWlSIZsDDVUJR+h96zkFMQowdPMPbA7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb2e5a1-eb85-4f45-ea92-08dcd14f2b0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:13.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1YbV/7E42pYhfdOYr5F1P8DEub/9wB/qqBJ7dBRqesOKLMmcUgYz5BhPeEM77ajDKMUINJd/lM2KIE/aRGJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

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
Therefore pgmap is the same for both head and tail pages and can be
moved into the folio and we can use the standard scheme to find
compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

---

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 |  8 +++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    |  7 +++++--
 mm/mm_init.c                           |  2 +-
 12 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 6fb65b0..58d308c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_dev_pagemap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 210b9f4..a58f2c1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -199,7 +199,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_dev_pagemap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1022,8 +1022,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_dev_pagemap(sg_page(sg))) {
+		state->pgmap = page_dev_pagemap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..14273e6 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
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
index 002e49b..9a85a82 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -207,8 +207,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_dev_pagemap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8..c2f1d53 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -129,8 +129,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -299,6 +302,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -337,6 +341,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+			struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4..e191434 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1134,6 +1134,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
+{
+	WARN_ON(!is_zone_device_page(page));
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1149,7 +1155,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_dev_pagemap(a) == page_dev_pagemap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e4..b072ca9 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_dev_pagemap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..a11807c 100644
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
index c31ea30..d2785fb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4024,6 +4024,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4048,7 +4049,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_dev_pagemap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..e885bc9 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_dev_pagemap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1..9d30107 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_dev_pagemap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_dev_pagemap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0489820..3d0611e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -996,7 +996,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1

