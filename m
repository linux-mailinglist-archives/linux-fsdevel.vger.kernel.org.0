Return-Path: <linux-fsdevel+bounces-38518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E4A035E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304AD163F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23BE18628F;
	Tue,  7 Jan 2025 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TqZ1yjz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5467081C;
	Tue,  7 Jan 2025 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221388; cv=fail; b=Zg0Hw4JtD2KjK3vNIxyPjjwtsz1WThyRxv0fSwcxRdYpgjIOvvR5/WXVI2zUaD/6UTYfBVubOxQNhKEh9tFppO62SaEBiaWN+LtuvgeWGBCGZ7XOjoksiZIVVoxoUxSlCCfwPow5bT7SxdqBdLZhILfkzaNFpWyiBT+INfh+hgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221388; c=relaxed/simple;
	bh=RVF3vd3vgIe36sq4f3txqO6R1RQVwzZG/AMJ7LEPxfM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p9hV+q+UemQtfqVZdc9ufqwDfqwr5if37+zLTirpNsiLlk3Hj3VfiCmwd3JyfEkpsMCu66y6Isp0QH2AkfYeXOw1iU0EhrOstJ7AE3ql0N3uQQosp8sBafZgV3Ni0xssvFUlVKHLZLs9qSEP9ilYLT/OiLCXNJRr8xTt/ChL2jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TqZ1yjz/; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAHcBqc0Wj3DnzHirHG2Sf1RldR7g6DHSq1m24G1RbomBvSpBndqG0MW+6PLZhMagaa6SSJ7esK0gI/zF0IAHuIuTwiwWgs2vUafXDiHSi6Un3llbv3ly+6XIiGUf5kjY+kzWxs5IvbCU1ETwkBDQsPLMckKoAAC3e6HewgkNhsEMOWILpzCGGdcTIY1uRNnXki3c9+9qE2SFAAOZEY/GTPEhOA4/Cal18t+oamxfvSUWdThYzZYxyy4YmmeQd845r29KR3QylKmj1p73jG/jiJEveKanv2HEfMjzh/Bm2IU4UKeB46g/ELyHUQjqEIy1tYlf2dPpKcoK516xNpZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X43t5dv7g5WgJoP9aPIIljf0v/lCzc213uJ164W4vxs=;
 b=vOgo5q6M5xo4gexLdSMKUGKdT2bz6HgIvs5GOpFN/lOZo4oRlWzur22swLTKUXzeDEl+ooaOiYldqy3QNbJ53clS+zXnJQLar/P1ii9L2XPglURsKg///EEyOtKz9AMAPCoNdrsw+B3DyDGsDj7wm6fNW9niBoAweoe+UpEYd7z1suVuNs8iAzrr3zvivayXbO7ytXu1/rXf7pKSlYJT4EkEcdAI9AqwVGt2LcxJR4EVkHsa27/Bf4wz6qeszfk5xFRVq/rt7WFa2IRyjovGMCPo5x1dSvERpRyKSGcz0OnvepMoxOGe65YHfeZkk/caSUA0JlbRXu1tqfcNTQCWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X43t5dv7g5WgJoP9aPIIljf0v/lCzc213uJ164W4vxs=;
 b=TqZ1yjz/QkTwcGeyUpy5VjLluVyorCgEIDsX87fD9rVT8nTyYvXCoocEX6+nHInSCbD/J2dcILL7eXItdbU3QRHuL8qMciRTilHitINS5mM5txPyazSY14tGyItq8fLLEVsp0HKxzCf9EzgD+ZsqlblHeQwwonOHsnzPg4KbQoCnvYCJlmlOdgzRs08nyrqhLQlCa20u6KqBQcCUvDsdQW9umtw8DBnWBjpWCw4K4+DUn0I1WXpuU+//oqL78zEtCx1lFrcxW650voNI0fBydRMddFLqom+RQs0F7mw/Hhd9cVP+637KzmweY6r8XoDedO63s9McSR0JhtQmV0NTWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:42:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:42:58 +0000
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
Subject: [PATCH v5 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Tue,  7 Jan 2025 14:42:16 +1100
Message-ID: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0088.ausprd01.prod.outlook.com
 (2603:10c6:10:110::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8aa9e0-9fdc-453b-7c70-08dd2ecd6083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RG12XH8EZ18D9Qd53itNRacFsW/mM+lY4I2Q5nh5oy6sp8omtQ6tNUsI+4zt?=
 =?us-ascii?Q?BqKa8QAqrkKKv0Q31MTHfac+2ycW43wrsSHvsMBeOUozq/9w8TevQoJ+L3aG?=
 =?us-ascii?Q?I0GboJL8MYGr6oB4NueD2utu2xJ+xTy0ECuqTLWPAdJxZjCdmiAei7Y86Y7J?=
 =?us-ascii?Q?9kGkGUNS+a+aImzr4AmSmuk2rYJFG9pVdrjzhOKNo/0QQ9uoogl+y8txMxmQ?=
 =?us-ascii?Q?8SyLiDCy91FcEzNXQhlILdKwgbappR8pLBDzAe4AxY8mU3hjq77DDasQms7C?=
 =?us-ascii?Q?sLdOlnaazhmaSV73q8pVPMJ8wWJ0GAMDMHasSaDmW301ywRNGaCIFc9eAM2B?=
 =?us-ascii?Q?dSU+j5mvtVZ7UssbgAqqmj7+T+yYnl1H9INwZQT/miuQXdAk8JN2umCNvplO?=
 =?us-ascii?Q?aEd3f92bLOJXs/3A0dqiyU1h6D8yInmMNq+Zg9L+s6dWpXePMXhSrvayplHq?=
 =?us-ascii?Q?wJhFVamvpbrFU2iPkhCb4BD3UskaSL5KGhkHUhxTVcjpL5i+Iir210Or091T?=
 =?us-ascii?Q?7BWb2jXNRFGnPGjqYteFmlHtB51bRvypMehobTYeatm9j2Uh+x+Q1/mhxT49?=
 =?us-ascii?Q?BwyA/hewXxmmQ4OVRwJXWS8aLbU38jbbjgUBMR8V8989rIZjFanBMtEebfi1?=
 =?us-ascii?Q?cuA41ZnoDuR/gBJCUEGPdbwGJECam1Au1hIhv6e7HZ8rEFsROVOpSpwo1XWO?=
 =?us-ascii?Q?ybJpOHTkyKot8sP1ikhGf5uwYoh2YS28Y1SSZEfCfYCrcNI73KHIoas3kXdb?=
 =?us-ascii?Q?zyngyj2J6uqGaMOVgpEGhIXaiDvnrK6gvzWxvsHTghS5cqvDcToAbYTI/fBl?=
 =?us-ascii?Q?aHanlOkG/oCogSTUYlIUP9uR0noKIvUMhwktsi4NXOxJi8ErhL4wVGvD5flX?=
 =?us-ascii?Q?6AMb7WpXNsaMp8mxfWMwV2xGjUveDtnc2WOM6mR6SVuhYJBx1XWa2V7+wCKu?=
 =?us-ascii?Q?rFcSbSlQA9FuLRiNhMNI8uysUnqC0nhOHx1CSxzS6twO5l9l99Cu1eVxPoKf?=
 =?us-ascii?Q?be/M7dQoAR9qCfxOXHojNBirBQcey6FQe89sXg2PsV1jm6TZU+V9yu+UpL09?=
 =?us-ascii?Q?tyOJOvUG678UkYO39qcngb6LkF9OIG7qcV83MzFbFgFldDFm8SQ3YzJhnCc9?=
 =?us-ascii?Q?ePO95sa75UymrBt0bXLS/cZvaKxuE8IsUId3c7ug0mXQ6Ll0pXMMXYGh0HAJ?=
 =?us-ascii?Q?jOJjIMxdXeCqRxRIv20ATeAILI1++jL4tKNIoBCZwaO5DA6QlY3wBavn0J0Q?=
 =?us-ascii?Q?J2ssV3/H/NAQFWSLHLDD8k3DcH1glnmFCmbsflIIV5X4QfrkX8uGx9iOPrFm?=
 =?us-ascii?Q?R4KSYYH1ryZy9mwnJMG8UoFsCY+htt0obMUloNZ6izbB9TUdFHqJvR72HkWD?=
 =?us-ascii?Q?GZmNCHHIV72Gfc3vdddowtW0bHEB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHMqhHTrqQkcwNQiCbVbZwin0LvCmEkO9+ePw28CmBNY5+gRsZaY45pE6BW1?=
 =?us-ascii?Q?x+be1CceTjom+7ae/xL9vZGhnD+0lNRfb55jKstKZ0MRvmkQq6Q5x4XNcZ+c?=
 =?us-ascii?Q?1tT5+vQG+vfKgQZzHIEolvSZvE3lw3X3+OKR2zqKEnwJ9TRCRyfus+khQRe4?=
 =?us-ascii?Q?/MI4fbhuFI9r5Lum3zMSlz+oBvQFac67NgLqnSEfLgkFpDV5acRDzsAXX3U4?=
 =?us-ascii?Q?HWRnCGVeFUS2gxvYB1sHYK2lp3CL0iPUZo9EEL4bYPnitpcJXQ/XCQuficuj?=
 =?us-ascii?Q?OxCF703ZBGBO3y/9nJe0M+5ox7IY0eQ2WwHk37MfLtahfQ4eFU6fMkEqqbuW?=
 =?us-ascii?Q?opBCNgZ7SrniNTktTEHZFgDgwoJ+SqXpth9ad8zpo/BE28Jup7X0bFt2djDV?=
 =?us-ascii?Q?PcX/Wcu1vmX+FvfWoa3uEhHH39IzeEaiP0PsNbJ4l7B/uLhhYZRQngS8PraW?=
 =?us-ascii?Q?5s0vXHHFxjNCFVx/e86Zzc/lSHs5gtIaHHlbjdHgiDavbS88suzfvopuq4g3?=
 =?us-ascii?Q?I/4+T8LkqA3HUqbG3Zf2qiy/GIgddi0UyRFCsOy42EeDdibgxe9XZ0A5DZJJ?=
 =?us-ascii?Q?6VYeSrRp/tYz+q2/JULgSO4eHvMeyxb1pdbRz7AFz032iEYel6KxcaUd46+2?=
 =?us-ascii?Q?DZFpAORHkMgC7w01D9rWHyC8xPS8z474XHL1y9ZJGkmtsmHnQXOeBN/KoJAU?=
 =?us-ascii?Q?8A8zbRriKjOxBGHVM7W1tpwtXfMyuSA9T6Bvw1/KW4nojP4GYh9IjPrbBNX5?=
 =?us-ascii?Q?BJaogzSGSqsrbdDK6CR3KmrfqgytBwYYN4Z9AwKCBpBY3Aiy95IyWTEZrLfz?=
 =?us-ascii?Q?+nZZ+IR68E6PI+FpCWU/tS3ZIJkU0Y1Ps2Pgkmg4eOKpVMKcfK2d8sD+NtTH?=
 =?us-ascii?Q?MSHQBEyFaGrzoB97dvaUkA2+1H/FacQet8ZysRGV45oCZrViNkOFI3EDFv4E?=
 =?us-ascii?Q?HU4aGoSes8WRPl6tvcoNgOCFSyZh2lHWYnYT58VFXBGf7FIJKfESPpV4ozwJ?=
 =?us-ascii?Q?EVFImUTWdTPqIdicrmEY50cIgYsVGhanOYdwbbZcuRBsmVXERIGqubrFB3qF?=
 =?us-ascii?Q?yCeSrlO4bQgRRQOnsSTnogIpTJ2pLedSUgUNQeLivu3brlu62DWDuLu0eQVP?=
 =?us-ascii?Q?N28QH1it/358/I6vhRt+B7+1wXwzAzRh4HBWpNFnxdxblf2KJ34qjSNbFmBx?=
 =?us-ascii?Q?7rrIf0JQCC/aRcxrLc2clHsAIkYQN/SLpxopbDbWwwewDw6bbgYox2xG6xen?=
 =?us-ascii?Q?AbyvfB6wOdMWFdQDR0TXg8nh6WOwJDS5QFLB7NlJGFc9aL66T51bvyR8K+Qb?=
 =?us-ascii?Q?ZuZFZiNE06+E5gRim7xFo/N6biDyzD3YibwvsLOgexVYEHAA6X7us93ywITi?=
 =?us-ascii?Q?KSPEb+wjr0VE3KxXBcatfZ6iQGjq5aLavDgh6RhqBcPC3snXkStx422IXCY0?=
 =?us-ascii?Q?RM5wMKc7EbFsWh78uQz1UBGPF78o4sNXHfxo29+Zzgd4UU2BnIaz1Gx3PSGA?=
 =?us-ascii?Q?eOn+AUc/OwM8C0zZFugiYhLNsy26IEtLgX3yYmACW0fIvyFSJ1Hcw7RPL5Gh?=
 =?us-ascii?Q?HfujfsmRhh9uawAQesOV3oWV97DgGU+ib2vCkCnv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8aa9e0-9fdc-453b-7c70-08dd2ecd6083
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:42:58.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbU9hfeg8hAqrC4MX1phw5kN4H0MhVtNDctpDEILFpF/E2x6YKEXvS9/TrAiYvsuJAy/saQPICBhMxkN2d0EaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

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

Alistair Popple (25):
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
  rmap: Add support for PUD sized mappings to rmap
  huge_memory: Add vmf_insert_folio_pud()
  huge_memory: Add vmf_insert_folio_pmd()
  memremap: Add is_devdax_page() and is_fsdax_page() helpers
  mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  proc/task_mmu: Mark devdax and fsdax pages as always unpinned
  mm/mlock: Skip ZONE_DEVICE PMDs during mlock
  fs/dax: Properly refcount fs dax pages
  device/dax: Properly refcount device dax pages when mapping
  mm: Remove pXX_devmap callers
  mm: Remove devmap related functions and page table bits
  Revert "riscv: mm: Add support for ZONE_DEVICE"

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +-
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  52 +---
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/riscv/Kconfig                            |   1 +-
 arch/riscv/include/asm/pgtable-64.h           |  20 +-
 arch/riscv/include/asm/pgtable-bits.h         |   1 +-
 arch/riscv/include/asm/pgtable.h              |  17 +-
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  51 +---
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 drivers/dax/device.c                          |  15 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |   3 +-
 drivers/nvdimm/pmem.c                         |   4 +-
 drivers/pci/p2pdma.c                          |  19 +-
 fs/dax.c                                      | 363 ++++++++++++++-----
 fs/ext4/inode.c                               |  43 +--
 fs/fuse/dax.c                                 |  35 +--
 fs/fuse/virtio_fs.c                           |   3 +-
 fs/proc/task_mmu.c                            |   2 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_inode.c                            |  40 +-
 fs/xfs/xfs_inode.h                            |   3 +-
 fs/xfs/xfs_super.c                            |  18 +-
 include/linux/dax.h                           |  37 ++-
 include/linux/huge_mm.h                       |  12 +-
 include/linux/memremap.h                      |  28 +-
 include/linux/migrate.h                       |   4 +-
 include/linux/mm.h                            |  40 +--
 include/linux/mm_types.h                      |  14 +-
 include/linux/mmzone.h                        |  12 +-
 include/linux/page-flags.h                    |   6 +-
 include/linux/pfn_t.h                         |  20 +-
 include/linux/pgtable.h                       |  21 +-
 include/linux/rmap.h                          |  15 +-
 lib/test_hmm.c                                |   3 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  59 +---
 mm/gup.c                                      | 176 +---------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              | 220 +++++++-----
 mm/internal.h                                 |   2 +-
 mm/khugepaged.c                               |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   | 118 ++++--
 mm/memremap.c                                 |  59 +--
 mm/migrate_device.c                           |   9 +-
 mm/mlock.c                                    |   2 +-
 mm/mm_init.c                                  |  23 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   5 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |  14 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/rmap.c                                     |  65 ++-
 mm/swap.c                                     |   2 +-
 mm/truncate.c                                 |  16 +-
 mm/userfaultfd.c                              |   5 +-
 mm/vmscan.c                                   |   5 +-
 70 files changed, 889 insertions(+), 929 deletions(-)

base-commit: e25c8d66f6786300b680866c0e0139981273feba
-- 
git-series 0.9.1

