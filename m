Return-Path: <linux-fsdevel+bounces-35530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C09D57B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502541F232BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAB1DEFEE;
	Fri, 22 Nov 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qt21ePJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208A1DE4FE;
	Fri, 22 Nov 2024 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239778; cv=fail; b=JllXBASXJNdE06w6YzXZzCnG/GfIb2tg4o+FHDBKQKuHcb+0aLV/ugQ98dr7FgSN8MOlL5RwEC85lgRY7IxBjO01C6RnEdLENUgl32YK7oeMHy4xeiiLuYBRtvKUdFhrhfMswsVksNPXoZKh5N4HNkmzu6/CN7FirJ/gvxEfWv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239778; c=relaxed/simple;
	bh=IXrwvdSUmsSy1KSIN7Qq/Z6stvtQxYeoKfH4FLsWF7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUrYZ+ozU2qX9yGwxVd0+JGHjTKjWrwkDQHxdoimMVpDaJ1xjHUqxE/wfHWv72F1qkkwivZievqbXInhTVDPdRIlecCLvBCT/GUm8JdhZx+SYnmneMa+aorZEsNEySbmzmfrrtFxjJ7JHEdM1ofRCUdxWEsfYE8KmTCItel9e2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qt21ePJo; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctsLsdqO04xQD9WErOHJZxc89R1LIHblsKGGpOcIFQ/fOxAkZidEtiIMGc5XkezqvVpY2j6m2iEfkdDK/gtfeo32lEc6PhbyrcJIMcTW4hzO2t7CHIXuCCMVjjYpcIizR0oolqpWsWA0wzZ5gzzGuXi5lXtG3v47TwOT9UzS5GFG/K97Bx+4nasou+unGABsCw28fT/NeSFoNh/0JnyNBTsmm4a3hxM9tmF58a56YSAmhgU+fVIccfIdoDmp82i5s3GQOdEKuw5oPlRpVr1+AR59/jvtwFOzrs6oReob14yx6Ya7Jl38wTp6FaMOB2saheTyfXI3XcdWUmzUk+PgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWDu2JtnIVZqou/gv8q22HEsDaWS10l08SaCQCPDMDE=;
 b=BMZPRPocE9vacVyfbHVimsc253FaX0h0o8/2Uct0dUGcdDg7ew2dmnCTf2A5Uq3qN9PH0xEtDgUMeORbLYG0GQx+eg0A2NdCLrNqb2N6b+lME6MD/TIrCLXtIt4r/rK85H6lgMWpssGz8ytFbNULbj1I8Qz2tK5tFAmoYNieelAYENFKYp12J7CmTN0uC+i9aMdqiCJAfOcI0n5+cE0+8/fza280/3E18Sb6+EwLHkI/a0ucPc/ib4sqJ+pz0g8YvGKFRldHgXGt9Qgc6v4AAcuSjd72K8tyPWzp7daGVaX79nsSi2E1woVaLvHJG8Xj/Y6faKkugydR9CidtabCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWDu2JtnIVZqou/gv8q22HEsDaWS10l08SaCQCPDMDE=;
 b=qt21ePJooRIXgU7CtPmEpGcZ1DtQnnG6ogZpqbAM98NzmMjWFoUowMI1oWrrcfy06+5Gv9gjAPQe5+6OuWxqd4lJdnSgfw97O6Tqj8borj9AohDAeEqpaPcCUOYHwaoLNwzjMRhSzpMqps9V8ULcfFjIsVHFUtUEN73W0xY9Q2rNhgSq7JW/fWH1dWDLsMX8NuqjW+O3qBkngsr+qjtyGVRDWXFofQTvI17ospZkBDRKOMFswfa2cAlBqSXxOSWarFoFInyFyIfBt9zBoJ0MT7SCVvvjLkMNDxS2PhDSVv4PZSVlm+x3G7IU1jUm/R2j4B8xJNM8HtKJB80izAh7vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:42:50 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:50 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
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
Subject: [PATCH v3 21/25] fs/dax: Properly refcount fs dax pages
Date: Fri, 22 Nov 2024 12:40:42 +1100
Message-ID: <39a896451e59b735f205e34da5510ead5e4cd47d.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0180.ausprd01.prod.outlook.com
 (2603:10c6:10:52::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcaa455-2f1b-43a3-a188-08dd0a96f92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5rJZFCo4tGiDm7QWP2qdNE2PawGz0p7Nk5BKhVIYPAyag3pUTV0qq9nprar?=
 =?us-ascii?Q?V7W0fUqonStnsq1sUG4biLSb5IexJMFuslcGhaLvuJ55//Oh7m1K2+9mhWH8?=
 =?us-ascii?Q?Yl794XIQJ81pwHDj5KJIcNqoPPKlSLVrnwEHxd/M4aKiqVL/cbKtsxXv17wz?=
 =?us-ascii?Q?mrqvmRyYdpCigH13uMxtlKfRJJ6XaV2GRnz9SFsOIPYjS3qipLVLV4SehPKX?=
 =?us-ascii?Q?Ee+CLlux++7dsfa1mFEP+bhVmeVEQ07y7/BWxzH36A7YSjQGN63Ro+ymmLpf?=
 =?us-ascii?Q?lBvA3KFCcprwurzGsrx0/mFTtDsY4QXNXw1AH+6rhjh/8T9kjnhlT1Sja8Sf?=
 =?us-ascii?Q?aX2Z8ypKgMhCUbstVnM8sgei5+HXiRDmWdylbcs5tHGpCqyi+UmRBKXQErGv?=
 =?us-ascii?Q?OSr+cMith1XSN8XJkOIZugRooyFO2yVlbQ70++Oyn4TAXQSBhY3Fdjc8FMHd?=
 =?us-ascii?Q?0MaUQbUjVLnhQKDshW4rfedgkajZJioL3PucHIMbGnLVBiv/TBOS/Fq8zO+1?=
 =?us-ascii?Q?6/Jjs5hjvpuU7Cyq9CBFZq52JOuJdEe0z0amkJmBYq6G92QeJ+OlO0YSG7Dd?=
 =?us-ascii?Q?9AMqYad7veYL1/aLXLYP8c61kPdc8U7izE3HyI3z9U7FUspuyrMzsFNXCmRC?=
 =?us-ascii?Q?aGtFNM2pOwcnoZlXJvK9H75E4XX4UklNwjOEpXn1fzL0OY3mrD4tkDo1nm9g?=
 =?us-ascii?Q?Or+WO/Ip78bYidawMoi8FYztAMAHgKyCa0khpE4nd7KDu1A956hDa8rL2E+g?=
 =?us-ascii?Q?Rv1WJOqAXSYphhASEzNKdRQ9bhoB/RKTn9dZMAz6noLX/BUFRXGkm8DruYed?=
 =?us-ascii?Q?tRtr2bpDXkYgWm6RcFZ+ltk3+FMoJGoKw74Vmaw3o07K+/3KCsjH0CAkXaYT?=
 =?us-ascii?Q?3bXTtE7ra1uf64DNIHwzd90zLnTQf2ZxinFKD5yvSkKj0ryHP+REntTFykhZ?=
 =?us-ascii?Q?VXgOnlGanJdPARcWjfdNkgInwWo3TwViPqt87itV2FgX0DcbaBQoeIHp+NRN?=
 =?us-ascii?Q?rmmGb7Yp9AuW8MQRvOST+n5sohVFWCWU15e6ghqqtruWhPRCYe5pC2ZloAR1?=
 =?us-ascii?Q?HfKvejAJgFIVFcD+fDAwTI5/qK4lvj0VL2d4bmOsk3+Qa5rWm9hySkCfTmz3?=
 =?us-ascii?Q?5RBYYdHbDjiJXHfYkoCg1aSISi25GnNYEUIWCQgnu1hGT3HICwq/msOk/Ouw?=
 =?us-ascii?Q?ALusPz/0KQ951qmCdBZh4bf1KFEjdongqn9FTy7VWNrTYUHvLMSRB9bqhoB1?=
 =?us-ascii?Q?GBvyAsPs1sdqb9xaZHSuNJAj+z4fVS63rKRRuCSM+H2rwbXQc992WlZWQy6g?=
 =?us-ascii?Q?LjAkCXPBuWEZvOoNco86EEzk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZcfS3ODF1O7QsdHS6yihE8PHYTd6hdDT8RzDABNoARibCPcadufNcCOpJbH5?=
 =?us-ascii?Q?9qwhqLj9fxjDgB4wsA9fR/7w7PilxjoJkbezj20R9quCVbqJsH2rAGmEWRLu?=
 =?us-ascii?Q?nuLFOQC+YnTTitV8f+2f4+wK/tNdi6uJhOzzE3XU0x1IicMYj4dvdPPGKaOL?=
 =?us-ascii?Q?e9Uk0qZA6HXDmSZeB6+nSOCruxX2xxaIEVWY2/43Jz7U0tE32PZi2J3w5jGy?=
 =?us-ascii?Q?LA94hcRt/xLOVMdZbvWE5KW+2V7rUFlRZWI7UiwLbjEdYVfJiHRcRM8gRXFF?=
 =?us-ascii?Q?hqoLYrlqzTsy5v118lw65Dktic5yqP4IZLKn6avGiLkBfjL29d2Cevghrc28?=
 =?us-ascii?Q?6hJjVwOMgrmm9CCCKbzDMtTajn/VQSTHfzobk+zX6PaI7SV0/LGAQaeBb2WH?=
 =?us-ascii?Q?MVsiedN+Qsdtn8zAnGGt2dgmzg7mYhFJer6FAHdaYMyUARuvbzro/FoPi8RS?=
 =?us-ascii?Q?/KB1oZlsrB+Cl4HwhhHBSb6qbrzBe0xiTOTsnnAMpYIA2nug4XOA3kc/lcfW?=
 =?us-ascii?Q?Falg+uxDphEEqJyXRe3DwXTfMzzKq0nEAf9pVr339Gae8CouR5LEMakeNCIK?=
 =?us-ascii?Q?O2DEIoBThVuzpS3IzrZFqr+LkJFMP+xbn33g4xkbtGVFqe7wiZ688pRkCT++?=
 =?us-ascii?Q?sCneX2FEZR/HXqxhSt43lQQc31fQuA20acYHqnpTWlUDKPLLo9Fp6i6kLBub?=
 =?us-ascii?Q?HW4oRw1JA9yx/IPiaQPWj6DV8CUMwmg4LMyvkvXbLL6Gusnf7dU0LIbQmghU?=
 =?us-ascii?Q?9ygdWuGrDPR1jvWE+BLe7sDjBFYXE1mlWFmD0tFYAb0YNNjPCAIXeVrLCNIQ?=
 =?us-ascii?Q?i1NWbXzmQw98iBczJaj7sJDeTgVzH58hQgX+NLbjugt7I2b6yiWWNaJWRJ+j?=
 =?us-ascii?Q?w1OJTo4NbrxXis1BlZRkA4oeUZRlZdvu1T8hzmuqX3Trmnc7BAO2uM9pzE5M?=
 =?us-ascii?Q?TltLd5AxvurfbNGubFBPcIG21lplfkiJ1NC6xevIpoa5aGZ9K8TTEvXOpond?=
 =?us-ascii?Q?yPuGeQ/SenJuSC+5TGF0zLneWtZ6i+OZmk3/8LXdddfHUKr3uPYvTmiDLW0s?=
 =?us-ascii?Q?V9nmeM362dq7pwPqZkPvMKuE8uLH2MQE6E4s0nrYYQmWO/ZW8zfIOQ8FiOVT?=
 =?us-ascii?Q?uOsEs8PGcloFKL70JkN/oGKSNjO70KqfY0rtLBLNCQ1du0M0EsVCdQ6biUzl?=
 =?us-ascii?Q?hjlJUhSMOof72K3QgvUeK8XZVAXeKbJ1pWu0jewA4wkbkqRr2SJvjRj6HbzM?=
 =?us-ascii?Q?4lmChaWimfWv1nMOO1sLEvK9Nvf5l/A2r1vsWzMcM/hMMtQ1TiFp/zioKyfl?=
 =?us-ascii?Q?+z9OJpz0rf9hqkAG92tBRffyoKzZR/px6SbvWlo/8BK9/mYAY7tgfKpjdL3z?=
 =?us-ascii?Q?/CCc58UTuQkI6SEvGgtY+eqDsgq8nj/ectcQtTsBu0lKqAehTlMe0e6ol9cQ?=
 =?us-ascii?Q?Cyi78YBIJ+9QhD7pS5l85NA1Lw35EW+c56hemnRPG7zTmUr1RId0PwyXKcgh?=
 =?us-ascii?Q?MlpfJYD8sv3UspCrj0UnJBzafIZNM40c8LcxXOSg0O1orT5PiCtMx4oLLIGo?=
 =?us-ascii?Q?9TNRuUwrjHZ9jDfdA8eEUAMctkvcJleS4p7s2Q3v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcaa455-2f1b-43a3-a188-08dd0a96f92d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:50.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIEVgE4gjYG2kd7T/b3VkEcuTvOa5nBQx8vxH9Ht5P0bCYOFHJFBQpu3TMIw+e/MiGm7ye4CuMBi+qP+VpPzeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

Currently fs dax pages are considered free when the refcount drops to
one and their refcounts are not increased when mapped via PTEs or
decreased when unmapped. This requires special logic in mm paths to
detect that these pages should not be properly refcounted, and to
detect when the refcount drops to one instead of zero.

On the other hand get_user_pages(), etc. will properly refcount fs dax
pages by taking a reference and dropping it when the page is
unpinned.

Tracking this special behaviour requires extra PTE bits
(eg. pte_devmap) and introduces rules that are potentially confusing
and specific to FS DAX pages. To fix this, and to possibly allow
removal of the special PTE bits in future, convert the fs dax page
refcounts to be zero based and instead take a reference on the page
each time it is mapped as is currently the case for normal pages.

This may also allow a future clean-up to remove the pgmap refcounting
that is currently done in mm/gup.c.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

Based on some questions from Dan I attempted to have the FS DAX page
cache (ie. address space) hold a reference to the folio whilst it was
mapped. However I came to the strong conclusion that this was not the
right thing to do.

If the page refcount == 0 it means the page is:

1. not mapped into user-space
2. not subject to other access via DMA/GUP/etc.

Ie. From the core MM perspective the page is not in use.

The fact a page may or may not be present in one or more address space
mappings is irrelevant for core MM. It just means the page is still in
use or valid from the file system perspective, and it's a
responsiblity of the file system to remove these mappings if the pfn
mapping becomes invalid (along with first making sure the MM state,
ie. page->refcount, is idle). So we shouldn't be trying to track that
lifetime with MM refcounts.

Doing so just makes DMA-idle tracking more complex because there is
now another thing (one or more address spaces) which can hold
references on a page. And FS DAX can't even keep track of all the
address spaces which might contain a reference to the page in the
XFS/reflink case anyway.

We could do this if we made file systems invalidate all address space
mappings prior to calling dax_break_layouts(), but that isn't
currently neccessary and would lead to increased faults just so we
could do some superfluous refcounting which the file system already
does.

I have however put the page sharing checks and WARN_ON's back which
also turned out to be useful for figuring out when to re-initialising
a folio.
---
 drivers/nvdimm/pmem.c    |   4 +-
 fs/dax.c                 | 212 +++++++++++++++++++++++-----------------
 fs/fuse/virtio_fs.c      |   3 +-
 fs/xfs/xfs_inode.c       |   2 +-
 include/linux/dax.h      |   6 +-
 include/linux/mm.h       |  27 +-----
 include/linux/mm_types.h |   5 +-
 mm/gup.c                 |   9 +--
 mm/huge_memory.c         |   6 +-
 mm/internal.h            |   2 +-
 mm/memory-failure.c      |   6 +-
 mm/memory.c              |   6 +-
 mm/memremap.c            |  47 ++++-----
 mm/mm_init.c             |   9 +--
 mm/swap.c                |   2 +-
 15 files changed, 181 insertions(+), 165 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 210fb77..451cd0f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
diff --git a/fs/dax.c b/fs/dax.c
index d193846..45d04ca 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
+static struct folio *dax_to_folio(void *entry)
+{
+	return page_folio(pfn_to_page(dax_to_pfn(entry)));
+}
+
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
@@ -338,44 +343,88 @@ static unsigned long dax_entry_size(void *entry)
 		return PAGE_SIZE;
 }
 
-static unsigned long dax_end_pfn(void *entry)
-{
-	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
-}
-
-/*
- * Iterate through all mapped pfns represented by an entry, i.e. skip
- * 'empty' and 'zero' entries.
- */
-#define for_each_mapped_pfn(entry, pfn) \
-	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
-
 /*
  * A DAX page is considered shared if it has no mapping set and ->share (which
  * shares the ->index field) is non-zero. Note this may return false even if the
  * page if shared between multiple files but has not yet actually been mapped
  * into multiple address spaces.
  */
-static inline bool dax_page_is_shared(struct page *page)
+static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return !page->mapping && page->share;
+	return !folio->mapping && folio->share;
 }
 
 /*
- * Increase the page share refcount, warning if the page is not marked as shared.
+ * Increase the folio share refcount, warning if the folio is not marked as shared.
  */
-static inline void dax_page_share_get(struct page *page)
+static inline void dax_folio_share_get(void *entry)
 {
-	WARN_ON_ONCE(!page->share);
-	WARN_ON_ONCE(page->mapping);
-	page->share++;
+	struct folio *folio = dax_to_folio(entry);
+
+	WARN_ON_ONCE(!folio->share);
+	WARN_ON_ONCE(folio->mapping);
+	WARN_ON_ONCE(dax_entry_order(entry) != folio_order(folio));
+	folio->share++;
+}
+
+static inline unsigned long dax_folio_share_put(struct folio *folio)
+{
+	unsigned long ref;
+
+	if (!dax_folio_is_shared(folio))
+		ref = 0;
+	else
+		ref = --folio->share;
+
+	WARN_ON_ONCE(ref < 0);
+	if (!ref) {
+		folio->mapping = NULL;
+		if (folio_order(folio)) {
+			struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+			unsigned int order = folio_order(folio);
+			unsigned int i;
+
+			for (i = 0; i < (1UL << order); i++) {
+				struct page *page = folio_page(folio, i);
+
+				ClearPageHead(page);
+				clear_compound_head(page);
+
+				/*
+				 * Reset pgmap which was over-written by
+				 * prep_compound_page().
+				 */
+				page_folio(page)->pgmap = pgmap;
+
+				/* Make sure this isn't set to TAIL_MAPPING */
+				page->mapping = NULL;
+				page->share = 0;
+				WARN_ON_ONCE(page_ref_count(page));
+			}
+		}
+	}
+
+	return ref;
 }
 
-static inline unsigned long dax_page_share_put(struct page *page)
+static void dax_device_folio_init(void *entry)
 {
-	WARN_ON_ONCE(!page->share);
-	return --page->share;
+	struct folio *folio = dax_to_folio(entry);
+	int order = dax_entry_order(entry);
+
+	/*
+	 * Folio should have been split back to order-0 pages in
+	 * dax_folio_share_put() when they were removed from their
+	 * final mapping.
+	 */
+	WARN_ON_ONCE(folio_order(folio));
+
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1)
+			INIT_LIST_HEAD(&folio->_deferred_list);
+		WARN_ON_ONCE(folio_ref_count(folio));
+	}
 }
 
 /*
@@ -388,72 +437,58 @@ static inline unsigned long dax_page_share_put(struct page *page)
  * dax_holder_operations.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
+				struct vm_area_struct *vma, unsigned long address, bool shared)
 {
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	unsigned long size = dax_entry_size(entry), index;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
 	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (shared && page->mapping && page->share) {
-			if (page->mapping) {
-				page->mapping = NULL;
+	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
+		if (folio->mapping) {
+			folio->mapping = NULL;
 
-				/*
-				 * Page has already been mapped into one address
-				 * space so set the share count.
-				 */
-				page->share = 1;
-			}
-
-			dax_page_share_get(page);
-		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
+			/*
+			 * folio has already been mapped into one address
+			 * space so set the share count.
+			 */
+			folio->share = 1;
 		}
+
+		dax_folio_share_get(entry);
+	} else {
+		WARN_ON_ONCE(folio->mapping);
+		dax_device_folio_init(entry);
+		folio = dax_to_folio(entry);
+		folio->mapping = mapping;
+		folio->index = index;
 	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+				bool trunc)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
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
+	dax_folio_share_put(folio);
 }
 
 static struct page *dax_busy_page(void *entry)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
+		return NULL;
 
-		if (page_ref_count(page) > 1)
-			return page;
-	}
-	return NULL;
+	if (folio_ref_count(folio) - folio_mapcount(folio))
+		return &folio->page;
+	else
+		return NULL;
 }
 
 /**
@@ -786,7 +821,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -891,7 +926,7 @@ static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
+	return ___wait_var_event(page, page_ref_count(page) == 0,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
@@ -899,7 +934,7 @@ static void wait_page_idle_uninterruptible(struct page *page,
 					void (cb)(struct inode *),
 					struct inode *inode)
 {
-	___wait_var_event(page, page_ref_count(page) == 1,
+	___wait_var_event(page, page_ref_count(page) == 0,
 			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
 }
 
@@ -941,7 +976,8 @@ void dax_break_mapping_uninterruptible(struct inode *inode,
 		wait_page_idle_uninterruptible(page, cb, inode);
 	} while (true);
 
-	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
 }
 
 /*
@@ -1026,8 +1062,10 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!(flags & DAX_ZERO_PAGE))
+			dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+						shared);
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1215,9 +1253,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1324,7 +1360,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1784,7 +1820,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	struct folio *folio;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1816,17 +1853,18 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
+	folio = dax_to_folio(*entry);
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	folio_ref_inc(folio);
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)), write);
+	else
+		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+	folio_put(folio);
 
-	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return ret;
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -2065,6 +2103,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
+	struct folio *folio;
 	void *entry;
 	vm_fault_t ret;
 
@@ -2082,14 +2121,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio_ref_inc(folio);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = vmf_insert_folio_pmd(vmf, folio, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
+	folio_put(folio);
 	dax_unlock_entry(&xas, entry);
 	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
 	return ret;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6404a18..ae69deb 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1011,8 +1011,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index bdb335c..53ced36 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2729,7 +2729,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * for this nested lock case.
 	 */
 	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 1) {
+	if (page && page_ref_count(page) != 0) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 53a7482..7779e6f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -217,8 +217,12 @@ static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
+	int ret;
+
+	ret = ___wait_var_event(page, !page_ref_count(page),
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4f9ae37..052f234 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1085,6 +1085,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1408,25 +1410,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1541,12 +1524,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_folio_refs(folio, 1))
-		return;
 	folio_put(folio);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 209e00a..01c4a58 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -344,7 +344,10 @@ struct folio {
 				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
-			pgoff_t index;
+			union {
+				pgoff_t index;
+				unsigned long share;
+			};
 			union {
 				void *private;
 				swp_entry_t swap;
diff --git a/mm/gup.c b/mm/gup.c
index cef8bff..ff5f35b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -91,8 +91,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -111,8 +110,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_folio_refs(folio, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
@@ -556,8 +554,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b3bf909..0ac0e54 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2142,7 +2142,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2786,13 +2786,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
 			folio = pfn_swap_entry_folio(entry);
+		} else if (is_huge_zero_pmd(old_pmd)) {
+			return;
 		} else {
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
diff --git a/mm/internal.h b/mm/internal.h
index 93083bb..50ff42f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -687,8 +687,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 96ce31e..80dd2a7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -419,18 +419,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_trans_huge(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
 	ptent = ptep_get(pte);
-	if (pte_present(ptent) && pte_devmap(ptent))
+	if (pte_present(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 5e04310..1c91dd4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3768,13 +3768,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
-		 * VM_PFNMAP VMA.
+		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
 		 *
 		 * We should not cow pages in a shared writeable mapping.
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
-		if (!vmf->page)
+		if (!vmf->page || is_fsdax_page(vmf->page)) {
+			vmf->page = NULL;
 			return wp_pfn_shared(vmf);
+		}
 		return wp_page_shared(vmf, folio);
 	}
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 68099af..9a8879b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,13 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->pgmap->ops ||
-			!folio->pgmap->ops->page_free))
+	struct dev_pagemap *pgmap = folio->pgmap;
+
+	if (WARN_ON_ONCE(!pgmap->ops))
+		return;
+
+	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+			 !pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -484,26 +489,36 @@ void free_zone_device_folio(struct folio *folio)
 	 * For other types of ZONE_DEVICE pages, migration is either
 	 * handled differently or not done at all, so there is no need
 	 * to clear folio->mapping.
+	 *
+	 * FS DAX pages clear the mapping when the folio->share count hits
+	 * zero which indicating the page has been removed from the file
+	 * system mapping.
 	 */
-	folio->mapping = NULL;
-	folio->pgmap->ops->page_free(folio_page(folio, 0));
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+		folio->mapping = NULL;
 
-	switch (folio->pgmap->type) {
+	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->pgmap);
+		pgmap->ops->page_free(folio_page(folio, 0));
+		put_dev_pagemap(pgmap);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
+		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
+	case MEMORY_DEVICE_FS_DAX:
+		wake_up_var(&folio->page);
+		break;
+
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		pgmap->ops->page_free(folio_page(folio, 0));
 		break;
 	}
 }
@@ -519,21 +534,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (folio_ref_sub_return(folio, refs) == 1)
-		wake_up_var(&folio->_refcount);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3d0611e..3c32190 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1015,23 +1015,22 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
-	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
-	 * allocator which will set the page count to 1 when allocating the
-	 * page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+	 * directly to the driver page allocator which will set the page count
+	 * to 1 when allocating the page.
 	 *
 	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
 	 * their refcount reset to one whenever they are freed (ie. after
 	 * their refcount drops to 0).
 	 */
 	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index 835bdf3..bb06b19 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -969,8 +969,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_folio_refs(folio, nr_refs))
-				continue;
 			if (folio_ref_sub_and_test(folio, nr_refs))
 				free_zone_device_folio(folio);
 			continue;
-- 
git-series 0.9.1

