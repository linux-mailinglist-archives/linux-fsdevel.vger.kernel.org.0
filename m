Return-Path: <linux-fsdevel+bounces-41910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE23A39178
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92A37A3A01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0483C1A38E3;
	Tue, 18 Feb 2025 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5HJ3Lk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128271D554;
	Tue, 18 Feb 2025 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850953; cv=fail; b=SDxXLlr8jAO7cm0iiinFCyft5WEOuMiVwoP2TuEbzmlK8yR4KkRC+KeTK9W+v8Ijef3+TrSM17fTHwNaNnaj+nmyBgLslFYg5B2FhNXaMyc5JP23UaV/t9lLYVKxvNkMVoQ9Ye22bRxlbH6XADdThNcEInJ5wTVaT5ChzcBlz2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850953; c=relaxed/simple;
	bh=XCB5JlK6rLnB1dISWbotnOrQNCI+PlaNQMJYgujHN2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Pg82EnGyPknTh2ivCsyDUs27JcbyXuqrXwvCXu1aCTvYHHl8e+6SPByy1eeSaUCPLdLFqQ+uZr7RgZ91pXpXo+1MqAy6u85iDErOGQDbaortmg3K7xmB7UNKnNNDvwtEjaCI6tpkTU5LoG8NuEDjikH8RNVT5BuapuxYLr7sOPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5HJ3Lk/; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1+EGTUPKbtNYSN04gjvTJ4DPFAH0eDT4m5klfrHfHo/Nk7jAlTTMeMwcIVqAjljfj5Bi0yYV05jzdTIEJlUI59RzpZS4EqBT4djR4Z2zZtGzET4lCmusndsZpoYMG+FyZTLCagZUhz+xFFf4LZXNCuLlIZRrTVLS6dZbWFzumpoDRnOgEp4n+anIJ/0psRvMCIXGJkhG6OxqoaMCzAnI+bKc5sgibQz1P2IXpWMgOO77/Qx8s31ql1dBJltJMCsNgJa6BaRXXcATDcZcLmtdjW01XRH+oO0VnSqQg9hj9/rzW4Cp0KNzjYi9iMRSyDKah4aZP5CfiMx3BZWAoHG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/VKp2nf1QCgpbd3ASSbmqqYmz6e830auaO4USFstsA=;
 b=HcU1Q70kow5g+KFsRsN84mF3CwS2mNXODoczi0qtRA1V9NMIeIeLm7yddp6l777jV6xyyTR1OWIeM6/e/MNEkolC0B0QIqknxdVTHahtH2QwDdKzuY99BMZ2o2CEbdocr4wgWwLkJblnRwjjCiBcsjhRFAGKCpajcEv3u6VLR5C4Ubj+LqJ0z1UAAroST9g034KOSwtPes9hgLLtkE0JzNtUH59DH5MhJYADk214V/UXwF7GCzFgoS5i6reyDfkQjAHZR7GJTWxu1grW17CT2RT8+YVa1xixvGUmeisSVc/EGMS4BFg6EfGqZMjbg48v/SMyqlrgUWLbbeWWqzJX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/VKp2nf1QCgpbd3ASSbmqqYmz6e830auaO4USFstsA=;
 b=I5HJ3Lk/pcQrbwS+SmCMxsabpspXwWCEo4FEmb0SPrLHt6JvuoyvUXxsHGPPb4YyUL8N+QNIR1EMQ8EqDhQMHFxqLst62Ohevyk51uGmXz72XvdcflqVUxLto0lnrYHw6dyeiZbdKCFgxDtc6Z/OmbEpd8yH5+cBLvn2QEn5qgf4i+LwOL3KKoBSB5pj3dGWeNUf6epvDiPPwJaqUscvCt0cdaoiFHwXBSzJJBvCzUnneUbbodA+ERJTTfupf2jLrSf0WDQYo2SGHBAqpXpCJIwNaIB0PznARBeGoL1vAeMGwUBdHR+d3JvQgQMGtOUGZpBeaaURd2B8blm/AswJnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 03:55:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:55:47 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v8 00/20] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Tue, 18 Feb 2025 14:55:16 +1100
Message-ID: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0126.ausprd01.prod.outlook.com
 (2603:10c6:10:246::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfb6f4d-2f84-410f-5bba-08dd4fd0208a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G+dt0xGuyInHZh46a2Wv6W+zwzvxKsmZf6dTznnQ4mn0Uvz0GEr7mrD77tup?=
 =?us-ascii?Q?ntwDjNwX4+ooT4ecGGQ3OL96/Bn9utWagrXPrJ1TsGi45LRO/lv/+jLM1wBC?=
 =?us-ascii?Q?nQlzSuFCQJr0c7VALBKuJYxCkmMm2/X3mHyl1KRVz5pqRD8VS/JCHEM52Sb2?=
 =?us-ascii?Q?ceF+cqYYaZsPiUa7EgxspqWhfG3P7Zf+4APfny+ngG9zDgOxYwr6CCmxMN/v?=
 =?us-ascii?Q?4iBLCcPFNt6TDb24SgJ2ZV3sURI1wX1Ux7Kflj9asfePXQV2e3CSPM0RHWSF?=
 =?us-ascii?Q?Q8l9CCVOrAptgZrDlsTgnQ3FS/vyZrmJ8NzvsSuMbWSvoZtiAWfuDXOdWQF/?=
 =?us-ascii?Q?DgrLjoYTNhuVQLDws6PP5/O1trbxfpdDHxAEb8Gd0zpTljeyFNC4M9k3TFDU?=
 =?us-ascii?Q?1/pJAMECFFcP4cSOOzr+88XhqTTA4mDO4ti49NsKGMhSkYgX/ZQ0SmEtnh5d?=
 =?us-ascii?Q?poWFAM/qN4LRHkWwUXpuP6gQNeviICIsf0aawmHZ9R+1lzD78MARvjc4g5W+?=
 =?us-ascii?Q?2hsL6DLbQUo30bEMKexdo1sHthiNnlaVg9qTVqAv/ZY7B7lN6tm7/mS+q7s7?=
 =?us-ascii?Q?ABBiPdRAHZfnqFsiWLnNtWIEmDTEzMge+xxObaA0YqoakjPF1TkmQnUOdkFN?=
 =?us-ascii?Q?5wSglvSaY5SCCw5J15QoIwIcixHJGwevrJueT/8NsG09j6LRr6Jj6A2rwz6C?=
 =?us-ascii?Q?ouJ41EvgECBNHzsGLpLvQSviDGeCmicrp2FmsYYXUk4mz32yue+Mrtd/11YY?=
 =?us-ascii?Q?cuxc1jDl5yMORaSuw7tNrKlVpC1vdxyBELGL2MZ9rgJsGqnIYMx0DPletlda?=
 =?us-ascii?Q?gb6YCwNdIh6CPYDDnU0YCfPFME7a1TJUD86WBvCIBls4fy95iHDOe8RpI+xo?=
 =?us-ascii?Q?whBiegN256ZVJdaxW3iAulph0ggZv8FjgEq/m5cufCH1rLiezPVwI2gC5vo4?=
 =?us-ascii?Q?EjbfS4prylTsJhl4xEqrokU9b1uUg3VuTJ8YudLN3FCSdh+m34R6LFph1pEB?=
 =?us-ascii?Q?TP4mpAml8vFVuHq+Iod1bucBRDOn6M1iajLfZGtfyJz5kpVznguLFBe3Lclq?=
 =?us-ascii?Q?fLggus+DSfMFN7iHletl0dIANEt0W9d+yjz0iJ760yA4b/VwlbGWF5eVLC/9?=
 =?us-ascii?Q?raJIGXFwcZHWvrl+Cgg7tpXxvr1oeic2w91aw46d0qR0g5HVFQR9TVSefTmS?=
 =?us-ascii?Q?ShDBeTV3rRhenEYHlujbKqb9xkS1ISVvFvVOJ30svKkIv9IMQKmxDgo/mmgl?=
 =?us-ascii?Q?ug7igFDCdPbat22+YA4ycM4BjYnPJDeM1E7FHvaPuwWciSeL/ZALR240qRPl?=
 =?us-ascii?Q?wDLxPZ+kS0oWXdOa5hHM3lXduVV2vs/TXkkzwSZjQ7KisaXOsfJfZQ8a2qPA?=
 =?us-ascii?Q?FkC629bZOp8BNBAgFTZCBdFyZ1SD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1eU9MS5ShNhCShWDDRdJ8jR8Ccd9YTJ2TeM2MulSr1jcX5K9JHwn1TKeMCJ?=
 =?us-ascii?Q?ANEnmTbBEQYIVUU3aDBFYCAyjLkzNdBC2BeTwKCiTKRVkd0IrEAgpdDqy7fj?=
 =?us-ascii?Q?mCElKd8PJcg7Vy2jENRdQiNmLKzlXU0wUh87Vojj+OZ4eFGFyJnJJJxmz6U8?=
 =?us-ascii?Q?XFr/1Rb+K0MI95w/Vxk3M4LHCAp9dh9iOcIkQIqKoFzlWw7LBiSz5/ZUJoPK?=
 =?us-ascii?Q?YzZyJtWjemXLrGiw5hGFaNeTlaKcwDrF1Sw2e4kHlkfBCWnjddplimbacfEG?=
 =?us-ascii?Q?bmmR39T7UPC3Krd9gdl/CIo99aOx6WGhm5UO7WV/GRGZntYfjSR3ozkuGnEz?=
 =?us-ascii?Q?a2/nMiyR6wRKNZQGAo7QObGmrmGqT4CeH3ZNPo9C7zKhNtb8z8fp7pNn3iQr?=
 =?us-ascii?Q?n3evnJpSvct4Dwr8Aie0a53Kbliu6iLlGbVXlAmSv8Qa6dIolPW/KgaNMl7P?=
 =?us-ascii?Q?PEGdkhiHATCS9y0nPOykhzfnUEflDws1xcVS+JrFMVXcC2FNvOBMVZRYwFCH?=
 =?us-ascii?Q?moOA3+Wmx6vpSe4NA2DQWedw/sq3oynJ2ysJIjr+JToaC6JTU4PnLjG2RqLk?=
 =?us-ascii?Q?HrzH4R6sanhzR0VDqUZlucU89/4y04KKLURM5pxlFO0dT6thGqaO0oCLahmy?=
 =?us-ascii?Q?nx448adaPJaQuJm7p6VGH1CeqHDEGNAFS9K+jY3FBO+vbLlBFdUhpeaEKSwt?=
 =?us-ascii?Q?TNHXb1HQLZMxBqu1/Q6RWB7iMo7xv4yxCp0Pp30Yb7r4WgPFeMmqRXdfNYve?=
 =?us-ascii?Q?wO1GPSDVLPYd7IFjTXRjL6y0wpKv4xtY90qjp4m8FvkbnABDpu2vZ/ktZf8o?=
 =?us-ascii?Q?uXwrn2MmvmZ3AAYg8tKWlApm1ygT0z8SbFZwYFz/QnPB3j3Q5Zys5SFuxBxE?=
 =?us-ascii?Q?Vr+NMFgjYTdOff23eLSRYBo2hKituBIBZzHc1iBQrYPLEVzzQU506j94WVfT?=
 =?us-ascii?Q?jE9sTZ+/3L4VUS+VKgZmmyWzl7pxbNAii+ytOCvULgI1bb7ap3m7rnQ9SPvM?=
 =?us-ascii?Q?/I61wB3LraBmleBeYEJNien3/RUZk0IM6xjjNpinRz8eJZl3TXOu7A1ArEKm?=
 =?us-ascii?Q?08dm6tErHfvRktV8yikRLZBZMOXLBJNRindYJHln96o0S/YBsNlP+vXsGFvu?=
 =?us-ascii?Q?DbJHtWq9wiD2XcKd060xU2ad/DsfIM91X/6g8ZYiDNwpNhFF4qIlaWjYNIJO?=
 =?us-ascii?Q?0Uw3zx1pkdrDi7goDUTTDmpR/dgkW+uG0jtbdQZ0G4T5PD5fiUxIsViD/LEr?=
 =?us-ascii?Q?/ZvNQP+AlyystmLLF+QRS17KeAh+VXo8i0Q3LuXuHSLziIZCcyRgBm2QUzHI?=
 =?us-ascii?Q?uEWZy3ZYnIbi7DQRZK3NihUCBsY8qzq96nxGbAid7mptdZjZXBhFXSSFqxBf?=
 =?us-ascii?Q?4P2VO6+BR4bhl8smP4xwk8pReoR6Zgq8DhKG6qd95VZNRHcuV8IqIbaOWCLx?=
 =?us-ascii?Q?oVW4YC7EYBTqgsk26qHewM73HnmKwaUqwqUySC3XmXZ5O+YJlqnRnnKmRUvc?=
 =?us-ascii?Q?OnE0ewTZtJTKBGTfmMOFM+Yhus/MVTT8cq8YnfW6XxuYaJ8L4jh4hE6QMyGh?=
 =?us-ascii?Q?HEirzaKFJbtoC1YGmZhs+k2eG4zHp9dtlo6PTl9v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfb6f4d-2f84-410f-5bba-08dd4fd0208a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:55:47.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9R3O0/l6hI9BhYom8AKTj5BBEokGkCVGONGvX7QvvGR/XY/vJhpag8KCva7wLUmp9uqXDLNE+S+R3z5Nos7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Main updates since v6:

 - Clean ups and fixes based on feedback from David and Dan.

 - Rebased from next-20241216 to v6.14-rc1. No conflicts.

 - Dropped the PTE bit removals and clean-ups - will post this as a
   separate series to be merged after this one as Dan wanted it split
   up more and this series is already too big.

Main updates since v5:

 - Reworked patch 1 based on Dan's feedback.

 - Fixed build issues on PPC and when CONFIG_PGTABLE_HAS_HUGE_LEAVES
   is no defined.

 - Minor comment formatting and documentation fixes.

 - Remove PTE_DEVMAP definitions from Loongarch which were added since
   this series was initially written.

Main updates since v4:

 - Removed most of the devdax/fsdax checks in fs/proc/task_mmu.c. This
   means smaps/pagemap may contain DAX pages.

 - Fixed rmap accounting of PUD mapped pages.

 - Minor code clean-ups.

Main updates since v3:

 - Rebased onto next-20241216. The rebase wasn't too difficult, but in
   the interests of getting this out sooner for Andrew to look at as
   requested by him I have yet to extensively build/run test this
   version of the series.

 - Fixed a bunch of build breakages reported by John Hubbard and the
   kernel test robot due to various combinations of CONFIG options.

 - Split the rmap changes into a separate patch as suggested by David H.

 - Reworded the description for the P2PDMA change.

Main updates since v2:

 - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
   and have them pass the vmf struct.

 - Separate out the device DAX changes.

 - Restore the page share mapping counting and associated warnings.

 - Rework truncate to require file-systems to have previously called
   dax_break_layout() to remove the address space mapping for a
   page. This found several bugs which are fixed by the first half of
   the series. The motivation for this was initially to allow the FS
   DAX page-cache mappings to hold a reference on the page.

   However that turned out to be a dead-end (see the comments on patch
   21), but it found several bugs and I think overall it is an
   improvement so I have left it here.

Device and FS DAX pages have always maintained their own page
reference counts without following the normal rules for page reference
counting. In particular pages are considered free when the refcount
hits one rather than zero and refcounts are not added when mapping the
page.

Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
mechanism for allowing GUP to hold references on the page (see
get_dev_pagemap). However there doesn't seem to be any reason why FS
DAX pages need their own reference counting scheme.

By treating the refcounts on these pages the same way as normal pages
we can remove a lot of special checks. In particular pXd_trans_huge()
becomes the same as pXd_leaf(), although I haven't made that change
here. It also frees up a valuable SW define PTE bit on architectures
that have devmap PTE bits defined.

It also almost certainly allows further clean-up of the devmap managed
functions, but I have left that as a future improvment. It also
enables support for compound ZONE_DEVICE pages which is one of my
primary motivators for doing this work.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>

---

Cc: lina@asahilina.net
Cc: zhang.lyra@gmail.com
Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com
Cc: dave.jiang@intel.com
Cc: logang@deltatee.com
Cc: bhelgaas@google.com
Cc: jack@suse.cz
Cc: jgg@ziepe.ca
Cc: catalin.marinas@arm.com
Cc: will@kernel.org
Cc: mpe@ellerman.id.au
Cc: npiggin@gmail.com
Cc: dave.hansen@linux.intel.com
Cc: ira.weiny@intel.com
Cc: willy@infradead.org
Cc: djwong@kernel.org
Cc: tytso@mit.edu
Cc: linmiaohe@huawei.com
Cc: david@redhat.com
Cc: peterx@redhat.com
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de
Cc: david@fromorbit.com
Cc: chenhuacai@kernel.org
Cc: kernel@xen0n.name
Cc: loongarch@lists.linux.dev

Alistair Popple (19):
  fuse: Fix dax truncate/punch_hole fault path
  fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
  fs/dax: Don't skip locked entries when scanning entries
  fs/dax: Refactor wait for dax idle page
  fs/dax: Create a common implementation to break DAX layouts
  fs/dax: Always remove DAX page-cache entries when breaking layouts
  fs/dax: Ensure all pages are idle prior to filesystem unmount
  fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
  mm/gup: Remove redundant check for PCI P2PDMA page
  mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
  mm: Allow compound zone device pages
  mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
  mm/memory: Add vmf_insert_page_mkwrite()
  mm/rmap: Add support for PUD sized mappings to rmap
  mm/huge_memory: Add vmf_insert_folio_pud()
  mm/huge_memory: Add vmf_insert_folio_pmd()
  mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  fs/dax: Properly refcount fs dax pages
  device/dax: Properly refcount device dax pages when mapping

Dan Williams (1):
  dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support

 Documentation/filesystems/dax.rst      |   1 +-
 drivers/dax/device.c                   |  15 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   3 +-
 drivers/nvdimm/pmem.c                  |   4 +-
 drivers/pci/p2pdma.c                   |  19 +-
 drivers/s390/block/Kconfig             |  12 +-
 drivers/s390/block/dcssblk.c           |  27 +-
 fs/dax.c                               | 365 +++++++++++++++++++-------
 fs/ext4/inode.c                        |  18 +-
 fs/fuse/dax.c                          |  30 +--
 fs/fuse/dir.c                          |   2 +-
 fs/fuse/file.c                         |   4 +-
 fs/fuse/virtio_fs.c                    |   3 +-
 fs/xfs/xfs_inode.c                     |  31 +--
 fs/xfs/xfs_inode.h                     |   2 +-
 fs/xfs/xfs_super.c                     |  12 +-
 include/linux/dax.h                    |  28 ++-
 include/linux/huge_mm.h                |   4 +-
 include/linux/memremap.h               |  17 +-
 include/linux/migrate.h                |   4 +-
 include/linux/mm.h                     |  36 +---
 include/linux/mm_types.h               |  16 +-
 include/linux/mmzone.h                 |  12 +-
 include/linux/page-flags.h             |   6 +-
 include/linux/rmap.h                   |  15 +-
 lib/test_hmm.c                         |   3 +-
 mm/gup.c                               |  14 +-
 mm/hmm.c                               |   2 +-
 mm/huge_memory.c                       | 170 ++++++++++--
 mm/internal.h                          |   2 +-
 mm/memory-failure.c                    |   6 +-
 mm/memory.c                            |  69 ++++-
 mm/memremap.c                          |  59 ++--
 mm/migrate_device.c                    |   7 +-
 mm/mlock.c                             |   2 +-
 mm/mm_init.c                           |  23 +-
 mm/rmap.c                              |  67 ++++-
 mm/swap.c                              |   2 +-
 mm/truncate.c                          |  16 +-
 39 files changed, 802 insertions(+), 326 deletions(-)

base-commit: b2a64caeafad6e37df1c68f878bfdd06ff14f4ec
-- 
git-series 0.9.1

