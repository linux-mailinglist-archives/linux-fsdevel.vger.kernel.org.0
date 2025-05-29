Return-Path: <linux-fsdevel+bounces-50040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC8AC790A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCF2A481FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC1261365;
	Thu, 29 May 2025 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ldwz3Lq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79C257427;
	Thu, 29 May 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500409; cv=fail; b=ZaUgslnbiLuwmoiAxANIlq4a2PCcDeiOX0oWG0IhAkoL7VZCVztPP3bg9p/XzDuekLhcZOXmdt2n95vVNgZXVghMhUX9ehfxoRz3owSL8JPCF3OO9kJ4I3qHTW5aMqkD7QNxXnFlTQO0JKIqwhKaOBmFET4Z3gFJxdqrpQi49qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500409; c=relaxed/simple;
	bh=54leJFsex0g6kPCH+bm9w8akPMyp3L0jflkB1116lKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ToKBD/Usx6uMG0gKGqBft/eanBcu0vbeRhXO9XiECDC3MvzKyA1PjVjiqSKlz5wM4FWIo265O3IlnG4wgaS2f6KOrmJincFtblu4qLpbSUMn6yo1LQCGaDu6o2bYDO9uYoqvZ8UGuh9OF5IwQj/coFRtiCoa1HOtIvFK2qjt/0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ldwz3Lq9; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buQLRdeOvSPNMC7hdO6J6UMfXCfTir1II2vJGn0ycQHa/YRDLcNAs//or7N+iP7B/B2XRTxxqoRT4mYEPc52D73IdEKBiBP0VYNY/T5tpUOQYCQfOqbIm4VqfDjhgeMq/SjDKm6YG4r6/T4rJbTs5OkgnFOXN3o36m9uWNw1OTIw/zNq6Ald7oY4aw+yZ6iimsGDcBkEkm/e7DWRAXeeg29gHIhH5Mz+NPb9Uk35irEQMYEzWPZeAA5ZamsE7N9WwQ2V5zeSA7CdewnOPpkM/fFxVBDq53b0bQy3I+i17Ob6MNjElzgYs4jC3cxnLxX7qaIArX9HfcHxuKH3YYQuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eerLL0vhg34mPfVQZjFqa8nhwF5UEJfu2Q6xpIO0nUM=;
 b=CvdoRajPHHtrohG9JN2BfGTCpXev6vyEpJBfXyZEZqfoELsPfriVIPR7sBNYQMMtqkMSl3NgAZq3jSWzt0yzNmJLgYapIt5ssMhbQcqH1m1RY/WKY3CXlcFGD1cqI+CYIC80lZkF6Z6zaRABt3bk8pnrNxa2c1QVwqppu1IlCJ7gm6/Zm5/rEFdw9PYr8RweT5TOlbiViXqYCYwd703xCjaVIUHA7114N7KXD6Q48lH+rwRSNwrkOw8szyv0omsFCXBUMDqazfO/qkZWLQkB1zOkfQIetEqrwX4pus5Na1WLZE+cOy7cMBydFN+3PS78+/ObgcNjgjhN0SdZ9Bhb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eerLL0vhg34mPfVQZjFqa8nhwF5UEJfu2Q6xpIO0nUM=;
 b=Ldwz3Lq9xtjxTIskHotCrLA0WkyxFJSs+xtk8duylP0+d5HdkedMlpwWr34O8ReYqbMHkkHvHu8C/Qvg2NxTrNgJa76hhZACW/bCt9pksM23kYN8gJsJpxyFXowjTD9AU7QccdP7dHp3ttJ/mANTNlNHvFfq8pPKGzUdBLzLZLiKIuOSEwrFpLEz++MWQtF1Jdx3teUNQEY2euaDFxFFzf/m44DFFNRdO2OCp+aJSKvA2pcQyHH3EauAxC15hJWpQA2Iq5EDIjK+y007xlQLlW0As9J+wBQm3m6aYzJjTGsSnTj9cSQpFRMwOWfvxWio/Vd5CUrs3+KY49YTieTKvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:33:14 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:33:14 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	John@Groves.net
Subject: [PATCH 11/12] mm: Remove callers of pfn_t functionality
Date: Thu, 29 May 2025 16:32:12 +1000
Message-ID: <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0137.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: b8759714-4add-4bf6-adbb-08dd9e7ab0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zy8mxMmgkMorv49z0NCSZVOFAHXTR3fQ1+fTFoeaclVmKCaS+RdIht2MWMhZ?=
 =?us-ascii?Q?3dVPRwdj+GJHfQmyqhh4D7lz+IgyCWLwJJUYKjViqkxKhKJZTq7zqFlw/FrA?=
 =?us-ascii?Q?yb2OsjbBpYmnSqStuWE/eliXEMIM4oxww94eu8K+fmt6RZoQRmRM2NknaNAB?=
 =?us-ascii?Q?msJjp/MKc5mS+6BUwXQ317fXs9IAAGWAfjviiT1HjVovsigC6WE6++5fp9Td?=
 =?us-ascii?Q?ghiDkQhkFLv66YmhfBbwoiehChA4INclCQMKPeyj43l4LzrDKJL3GFdXs0lD?=
 =?us-ascii?Q?qCZpTt2pA7yrmiqXY3yh39H+kWh9gHVE09oPMEpp8KerQRqFuzZBXE6U6wMB?=
 =?us-ascii?Q?sKlYJYBzJETij1bGmw6DYIOrVh1VPmlGTPy1G9J9Pnhs73vS3GIq66pdhe2/?=
 =?us-ascii?Q?PY1q3KRWlMA4kPUn3Q+gFa/2A2tD7oZQZ1eNdWaU/ic+Qwd5pWHzRqdpUSoQ?=
 =?us-ascii?Q?05NOSMg74vvw/FTPbyckcXF8rW+bLZAVVK3kc089KomDKDTGM1/ksGNvGq/c?=
 =?us-ascii?Q?hqlnddC2rEZTh+09Aq4+VifyD1cVVIkbeawqCJcYZbweTkZEcB/1FjUXaJ7b?=
 =?us-ascii?Q?hqNUhfiOlIoNk7TDFETLr8ReTvuYM4WXT5zS96IABCpKlt4Umc4mzVRqWwqv?=
 =?us-ascii?Q?nUvZlMbjz7Nl1l/kYplWiT0rbRksDnrM8R5dy6ZHKGr5XSLTPUX3bzWzW2og?=
 =?us-ascii?Q?FQBe/I0RU2aXEu55JTadIFC4JXTkzOEuc08goA9abxYIKA5lSMN3pcAH+uJj?=
 =?us-ascii?Q?bkE06tq8spH6N2E+b74mpiyG2r3NBijnngMjAu3UubrBPodWtVaT4ZY5ufbA?=
 =?us-ascii?Q?myEFbJaDe9l4sW7Irnj1ftvoMxQR4dUqQuxNLOxBv0v0eiy0yNz5gqXwc2vD?=
 =?us-ascii?Q?sFnYgMUQLp67O+PsWi444JDvB6PbuXTVfLjvcjr07xT37yzxgQzPjmp59geP?=
 =?us-ascii?Q?vKIQnkLWxxBa+f+2PjSYEG67pkK9jxvjiEwzFkECEEGonduYpfbMnoQS3CmR?=
 =?us-ascii?Q?dAgu1NcctwCBM1tXad0XXwLaFELhVI5EP5tAAXqVZGEQKe+Xw5D8IHmHh/9E?=
 =?us-ascii?Q?wthCq9w+7kJ56g2G46uKojls/LPQ2Fgix3BFx+wx1+6LLSmrofOKrhXwyMgt?=
 =?us-ascii?Q?zsltWDQGETPiXcPSEOJhs6oeZHClb6ikQV80y8NqK3TLYjkSUOvEA+AqKIuY?=
 =?us-ascii?Q?o6ZA1MxQO1J4t1dcrnc7zku5BoGKrvcQOlgb/IZ3LSRgA62nPkntUBlwA2Dx?=
 =?us-ascii?Q?+REqLpc0bUEh9j2rBUODf48Cur8qQ3d4mXW5bCtph98YssuL0+0XonyXeG1h?=
 =?us-ascii?Q?Oc0rwOsLPH2NOZkGugmS15eUGP1X7BM7XGGHfo37Ih7LpMcPlNB30MUitIHX?=
 =?us-ascii?Q?JLtUxuU8pLGMy816+hUvbEGlJLCcKWdcv9hRvDYBtlibWyybah48htUVeJlW?=
 =?us-ascii?Q?hCYZzMdnUjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RpEnFspl70Q9yRQoYQ8gkw2PPA/kWEtaWWUxzhrms8FGs+Q0f0BE8Q46vVH5?=
 =?us-ascii?Q?hfdfuptC/ezp06bLSBntF11n+c/3on2pI1IHqDoff8FsgBkygoQVZHBuhuPQ?=
 =?us-ascii?Q?kth5tolxgvxZAayPO1gktMItUevYXnqTbsVVuskLAjsH2xzdi5AvVDXyPcJU?=
 =?us-ascii?Q?trQeoNnHW9clrIuXJegEy49VZ51A9fCUQpZXWHY3iJe1WFYpdAOrx/aoOlCl?=
 =?us-ascii?Q?9t2DECmVMXWREOtShiVonJWoysrL6nhnQzNPMeChOjBqMx256FRfmyrClkxK?=
 =?us-ascii?Q?iNvzkcZ9+zQhdJj90kWxLdNbD5d/iJp0Vwy8IMvBKotgs0YD28HPaHEKo8SL?=
 =?us-ascii?Q?gjHV8L2n6zE0X9GQmiBCIW38ekr/Fw8we7kfMhSbf1+Y+z2qfX+IiERcSZX/?=
 =?us-ascii?Q?Pvs+xRrgnsk0VF14II8QFi+2cJE4z5+AG0zEGSuWmM9zrOuL8Him9flI6ok+?=
 =?us-ascii?Q?MrZ9BbsYf/bA3ujXNY/4Ns6ktyEYx4hcggFmgpJYCfHeTDjBNVyF06iotnBv?=
 =?us-ascii?Q?KYOdi2qkUzv016Mu2cAXuhj0Rn26UwE9CPNO5wHMblf+9iUXQZb03EdexWo/?=
 =?us-ascii?Q?3vC+zk7r1nb7Z36isVBeXKfEEQlAyFqIP4nN4cuBBgYjNGJPU6r/cODNjUsJ?=
 =?us-ascii?Q?m3XU901o8xdzIGak56pvn3znfgbIyCf2QdpnfG9tNT4YPSQe4Cz5FE6eX5Qu?=
 =?us-ascii?Q?OIDVUgM1qsVREIeUGiATYWPDbLQJp84XIdbJSH5b+40PjKLyJi6SwovCEWPn?=
 =?us-ascii?Q?h9nmfgTLdS4ggEkqn/POYOVZiB63lxK/kK3oTKWDpUqPxMg3nCxl2gmyRhwx?=
 =?us-ascii?Q?5h7pv7DK8qFfiKS/kCD7EwY5koWSz+E9Iyy8Uy8bPeHLrneQXciXvcHpZpkL?=
 =?us-ascii?Q?qWGv+d50o72rn5IGzDgkEKhfNXEu264izVOHYc0511Fb33puEGyKEM9QIXIi?=
 =?us-ascii?Q?GSZ5XoqLIUsQp50uA0+0zeW8AcDOP08TAUkGs+KjraMIft8r/c+diYk2YS5o?=
 =?us-ascii?Q?+TS1sHbZTEGGqYdtnLCneXlIS7oFOs68oYt/X1Dij2DHkO9kLcpv9H1lrvuN?=
 =?us-ascii?Q?xNo5uKcO+BQfF+f7oPaFL8tSbOPs/wD/k7V+h0zqRpLUUJY2RiznbOkVaRTT?=
 =?us-ascii?Q?OkxNV6K6XJh5Q3yeFvllnhSy4DX1KfD1WD+guOvf5P1u9OjFYdjTetRTdr91?=
 =?us-ascii?Q?ZOb3ssRhkXjauxFnRAlC72OtJmI7Il9ddeKHkSQn3xOrDKvMUdKR0hD0IWUq?=
 =?us-ascii?Q?mT2YbJJ5HFet8iZZZFXCjdI/nqm76qfBhmZdId4OIZfjBLsnY3JuhLKOK/Wm?=
 =?us-ascii?Q?dOCT2LoUXhykOORV22Wplh9jCHr/Q7DiINoxFveiSgq4kBZccZnrsLwv95zK?=
 =?us-ascii?Q?vPJA2L7rEPxPkqkQ4OdrhrTbLvLe6rcXZMm8K/En5FhOiTGq4KideB3aIfAy?=
 =?us-ascii?Q?Zwet4QLmWR0e23zLKdy+zB8OYDGUqpz77pl3RRhgSX7pYwZ64gycq9Rax93p?=
 =?us-ascii?Q?gbv+UDgyjHErCBbYYZRmpAGnTlhafDd+Z0NNoPxlJ/8b4IIuSs35hKFu0yVo?=
 =?us-ascii?Q?V1u+79ZE0pTI1lLK9hyo6LEfjhSNH6tAkxflI9Jo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8759714-4add-4bf6-adbb-08dd9e7ab0a7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:33:14.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMsib9Gru/duBAmwGNb7DoZsOOvv9MBCQLbYz5VG8SWo+D3l6HLI9TE/gEYpEo/7mNnbNTeY6RsHHCmW8y2fWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

All PFN_* pfn_t flags have been removed. Therefore there is no longer
a need for the pfn_t type and all uses can be replaced with normal
pfns.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/mm/pat/memtype.c                |  6 +-
 drivers/dax/device.c                     | 23 +++----
 drivers/dax/hmem/hmem.c                  |  1 +-
 drivers/dax/kmem.c                       |  1 +-
 drivers/dax/pmem.c                       |  1 +-
 drivers/dax/super.c                      |  3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c  |  1 +-
 drivers/gpu/drm/gma500/fbdev.c           |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  1 +-
 drivers/gpu/drm/msm/msm_gem.c            |  1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c       |  6 +--
 drivers/gpu/drm/v3d/v3d_bo.c             |  1 +-
 drivers/hwtracing/intel_th/msu.c         |  3 +-
 drivers/md/dm-linear.c                   |  2 +-
 drivers/md/dm-log-writes.c               |  2 +-
 drivers/md/dm-stripe.c                   |  2 +-
 drivers/md/dm-target.c                   |  2 +-
 drivers/md/dm-writecache.c               | 11 +--
 drivers/md/dm.c                          |  2 +-
 drivers/nvdimm/pmem.c                    |  8 +--
 drivers/nvdimm/pmem.h                    |  4 +-
 drivers/s390/block/dcssblk.c             |  9 +--
 drivers/vfio/pci/vfio_pci_core.c         |  5 +-
 fs/cramfs/inode.c                        |  5 +-
 fs/dax.c                                 | 50 +++++++--------
 fs/ext4/file.c                           |  2 +-
 fs/fuse/dax.c                            |  3 +-
 fs/fuse/virtio_fs.c                      |  5 +-
 fs/xfs/xfs_file.c                        |  2 +-
 include/linux/dax.h                      |  9 +--
 include/linux/device-mapper.h            |  2 +-
 include/linux/huge_mm.h                  |  6 +-
 include/linux/mm.h                       |  4 +-
 include/linux/pfn.h                      |  9 +---
 include/linux/pfn_t.h                    | 85 +-------------------------
 include/linux/pgtable.h                  |  4 +-
 include/trace/events/fs_dax.h            | 12 +---
 mm/debug_vm_pgtable.c                    |  1 +-
 mm/huge_memory.c                         | 27 +++-----
 mm/memory.c                              | 31 ++++-----
 mm/memremap.c                            |  1 +-
 mm/migrate.c                             |  1 +-
 tools/testing/nvdimm/pmem-dax.c          |  6 +-
 tools/testing/nvdimm/test/iomap.c        |  7 +--
 tools/testing/nvdimm/test/nfit_test.h    |  1 +-
 45 files changed, 121 insertions(+), 250 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc..1fb57c2 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -36,7 +36,6 @@
 #include <linux/debugfs.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -1066,7 +1065,8 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 	return 0;
 }
 
-void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
+void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
+		      unsigned long pfn)
 {
 	enum page_cache_mode pcm;
 
@@ -1074,7 +1074,7 @@ void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
 		return;
 
 	/* Set prot based on lookup */
-	pcm = lookup_memtype(pfn_t_to_phys(pfn));
+	pcm = lookup_memtype(PFN_PHYS(pfn));
 	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
 			 cachemode2protval(pcm));
 }
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 328231c..2bb40a6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -4,7 +4,6 @@
 #include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
@@ -73,7 +72,7 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
+static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 			      unsigned long fault_size)
 {
 	unsigned long i, nr_pages = fault_size / PAGE_SIZE;
@@ -89,7 +88,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 			ALIGN_DOWN(vmf->address, fault_size));
 
 	for (i = 0; i < nr_pages; i++) {
-		struct folio *folio = pfn_folio(pfn_t_to_pfn(pfn) + i);
+		struct folio *folio = pfn_folio(pfn + i);
 
 		if (folio->mapping)
 			continue;
@@ -104,7 +103,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 {
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -125,11 +124,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+	return vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn),
 					vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -140,7 +139,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PMD_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -169,11 +168,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -185,7 +184,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PUD_SIZE;
 
 
@@ -215,11 +214,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f..c18451a 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -2,7 +2,6 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/dax.h>
 #include "../bus.h"
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e97d47f..87b5321 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -5,7 +5,6 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index c8ebf4e..bee9306 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include "../nvdimm/pfn.h"
 #include "../nvdimm/nd.h"
 #include "bus.h"
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e16d1d4..54c480e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -7,7 +7,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/magic.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
@@ -148,7 +147,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn)
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn)
 {
 	long avail;
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 4787fee..84b2172 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -7,7 +7,6 @@
 
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/shmem_fs.h>
 #include <linux/module.h>
 
diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 109efdc..68b825f 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -6,7 +6,6 @@
  **************************************************************************/
 
 #include <linux/fb.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
@@ -33,7 +32,7 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, 0));
+		err = vmf_insert_mixed(vma, address, pfn);
 		if (unlikely(err & VM_FAULT_ERROR))
 			break;
 		address += PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index c3dabb8..52fb78d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -6,7 +6,6 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 
 #include <drm/drm_cache.h>
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index ebc9ba6..1c27500 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -9,7 +9,6 @@
 #include <linux/spinlock.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_prime.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 9df05b2..381552b 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -8,7 +8,6 @@
 #include <linux/seq_file.h>
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include <drm/drm_prime.h>
@@ -371,7 +370,7 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, 0));
+	return vmf_insert_mixed(vma, vmf->address, pfn);
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -466,8 +465,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 			pfn, pfn << PAGE_SHIFT);
 
 	for (i = n; i > 0; i--) {
-		ret = vmf_insert_mixed(vma,
-			vaddr, __pfn_to_pfn_t(pfn, 0));
+		ret = vmf_insert_mixed(vma, vaddr, pfn);
 		if (ret & VM_FAULT_ERROR)
 			break;
 		pfn += priv->usergart[fmt].stride_pfn;
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index bb78155..c41476d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include "v3d_drv.h"
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 7163950..f3a13b3 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
-#include <linux/pfn_t.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -1618,7 +1617,7 @@ static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	get_page(page);
-	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn_t(page));
+	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn(page));
 }
 
 static const struct vm_operations_struct msc_mmap_ops = {
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 66318ab..bc2f163 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -168,7 +168,7 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 8d7df83..4c6aed7 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -891,7 +891,7 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index a1b7535..d554cf1 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -316,7 +316,7 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 652627a..2af5a95 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -255,7 +255,7 @@ static void io_err_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index d6a04a5..98f0c43 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -13,7 +13,6 @@
 #include <linux/dm-io.h>
 #include <linux/dm-kcopyd.h>
 #include <linux/dax.h>
-#include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
 #include <linux/delay.h>
 #include "dm-io-tracker.h"
@@ -256,7 +255,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	int r;
 	loff_t s;
 	long p, da;
-	pfn_t pfn;
+	unsigned long pfn;
 	int id;
 	struct page **pages;
 	sector_t offset;
@@ -290,7 +289,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		r = da;
 		goto err2;
 	}
-	if (!pfn_t_has_page(pfn)) {
+	if (!pfn_valid(pfn)) {
 		wc->memory_map = NULL;
 		r = -EOPNOTSUPP;
 		goto err2;
@@ -314,13 +313,13 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 				r = daa ? daa : -EINVAL;
 				goto err3;
 			}
-			if (!pfn_t_has_page(pfn)) {
+			if (!pfn_valid(pfn)) {
 				r = -EOPNOTSUPP;
 				goto err3;
 			}
 			while (daa-- && i < p) {
-				pages[i++] = pfn_t_to_page(pfn);
-				pfn.val++;
+				pages[i++] = pfn_to_page(pfn);
+				pfn++;
 				if (!(i & 15))
 					cond_resched();
 			}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5ab7574..dab026b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1232,7 +1232,7 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index aa50006..05785ff 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -20,7 +20,6 @@
 #include <linux/kstrtox.h>
 #include <linux/vmalloc.h>
 #include <linux/blk-mq.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
@@ -242,7 +241,7 @@ static void pmem_submit_bio(struct bio *bio)
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
@@ -254,7 +253,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	if (bb->count &&
 	    badblocks_check(bb, sector, num, &first_bad, &num_bad)) {
@@ -303,7 +302,7 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
-		void **kaddr, pfn_t *pfn)
+		void **kaddr, unsigned long *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -513,7 +512,6 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b3..a48509f 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -5,7 +5,6 @@
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/fs.h>
 
 enum dax_access_mode;
@@ -16,7 +15,6 @@ struct pmem_device {
 	phys_addr_t		phys_addr;
 	/* when non-zero this device is hosting a 'pfn' instance */
 	phys_addr_t		data_offset;
-	u64			pfn_flags;
 	void			*virt_addr;
 	/* immutable base size of the namespace */
 	size_t			size;
@@ -31,7 +29,7 @@ struct pmem_device {
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 02d7a21..1dee7e8 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -17,7 +17,6 @@
 #include <linux/blkdev.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <linux/pfn_t.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/io.h>
@@ -33,7 +32,7 @@ static void dcssblk_release(struct gendisk *disk);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -914,7 +913,7 @@ dcssblk_submit_bio(struct bio *bio)
 
 static long
 __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, void **kaddr, unsigned long *pfn)
 {
 	resource_size_t offset = pgoff * PAGE_SIZE;
 	unsigned long dev_sz;
@@ -923,7 +922,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
+		*pfn = PFN_DOWN(dev_info->start + offset);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
@@ -931,7 +930,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f2ad5f..31bdb91 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -20,7 +20,6 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
-#include <linux/pfn_t.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1669,12 +1668,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn, 0), false);
+		ret = vmf_insert_pfn_pmd(vmf, pfn, false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn, 0), false);
+		ret = vmf_insert_pfn_pud(vmf, pfn, false);
 		break;
 #endif
 	default:
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 820a664..b002e9b 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/ramfs.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -412,8 +411,8 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, 0);
-			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
+					address + off);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
 		}
diff --git a/fs/dax.c b/fs/dax.c
index 206dbd0..67bb647 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -20,7 +20,6 @@
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
 #include <linux/vmstat.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
@@ -76,9 +75,9 @@ static struct folio *dax_to_folio(void *entry)
 	return page_folio(pfn_to_page(dax_to_pfn(entry)));
 }
 
-static void *dax_make_entry(pfn_t pfn, unsigned long flags)
+static void *dax_make_entry(unsigned long pfn, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	return xa_mk_value(flags | (pfn << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)
@@ -719,7 +718,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		if (order > 0)
 			flags |= DAX_PMD;
-		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
+		entry = dax_make_entry(0, flags);
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
@@ -1053,7 +1052,7 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
  * appropriate.
  */
 static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		const struct iomap_iter *iter, void *entry, unsigned long pfn,
 		unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1251,7 +1250,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
-		size_t size, void **kaddr, pfn_t *pfnp)
+		size_t size, void **kaddr, unsigned long *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	int id, rc = 0;
@@ -1269,7 +1268,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
-	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
+	if (*pfnp & (PHYS_PFN(size)-1))
 		goto out;
 
 	rc = 0;
@@ -1373,12 +1372,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
-	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	unsigned long pfn = my_zero_pfn(vaddr);
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1395,14 +1394,14 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct folio *zero_folio;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 
 	if (unlikely(!zero_folio))
 		goto fallback;
 
-	pfn = page_to_pfn_t(&zero_folio->page);
+	pfn = page_to_pfn(&zero_folio->page);
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
@@ -1792,7 +1791,8 @@ static vm_fault_t dax_fault_return(int error)
  * insertion for now and return the pfn so that caller can insert it after the
  * fsync is done.
  */
-static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
+static vm_fault_t dax_fault_synchronous_pfnp(unsigned long *pfnp,
+					unsigned long pfn)
 {
 	if (WARN_ON_ONCE(!pfnp))
 		return VM_FAULT_SIGBUS;
@@ -1840,7 +1840,7 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
  * @pmd:	distinguish whether it is a pmd fault
  */
 static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
-		const struct iomap_iter *iter, pfn_t *pfnp,
+		const struct iomap_iter *iter, unsigned long *pfnp,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -1851,7 +1851,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	struct folio *folio;
 	int ret, err = 0;
-	pfn_t pfn;
+	unsigned long pfn;
 	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
@@ -1888,16 +1888,15 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	folio_ref_inc(folio);
 	if (pmd)
-		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)),
-					write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn), write);
 	else
-		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+		ret = vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn), write);
 	folio_put(folio);
 
 	return ret;
 }
 
-static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       int *iomap_errp, const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -2009,7 +2008,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 	return false;
 }
 
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -2090,7 +2089,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	return ret;
 }
 #else
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	return VM_FAULT_FALLBACK;
@@ -2111,7 +2110,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+			unsigned long *pfnp, int *iomap_errp,
+			const struct iomap_ops *ops)
 {
 	if (order == 0)
 		return dax_iomap_pte_fault(vmf, pfnp, iomap_errp, ops);
@@ -2131,8 +2131,8 @@ EXPORT_SYMBOL_GPL(dax_iomap_fault);
  * This function inserts a writeable PTE or PMD entry into the page tables
  * for an mmaped DAX file.  It also marks the page cache entry as dirty.
  */
-static vm_fault_t
-dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
+static vm_fault_t dax_insert_pfn_mkwrite(struct vm_fault *vmf,
+					unsigned long pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
@@ -2154,7 +2154,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
-	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio = pfn_folio(pfn);
 	folio_ref_inc(folio);
 	if (order == 0)
 		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
@@ -2181,7 +2181,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
  * table entry.
  */
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	int err;
 	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index beb078e..6167d03 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -742,7 +742,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0502bf3..ac6d4c1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -10,7 +10,6 @@
 #include <linux/dax.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/iomap.h>
 #include <linux/interval_tree.h>
 
@@ -757,7 +756,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
 	vm_fault_t ret;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
-	pfn_t pfn;
+	unsigned long pfn;
 	int error = 0;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_conn_dax *fcd = fc->dax;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 53c2626..aac914b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -9,7 +9,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/group_cpus.h>
-#include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
@@ -1008,7 +1007,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-				    void **kaddr, pfn_t *pfn)
+				    void **kaddr, unsigned long *pfn)
 {
 	struct virtio_fs *fs = dax_get_private(dax_dev);
 	phys_addr_t offset = PFN_PHYS(pgoff);
@@ -1017,7 +1016,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
+		*pfn = fs->window_phys_addr + offset;
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c9..3ac2a1f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1660,7 +1660,7 @@ xfs_dax_fault_locked(
 	bool			write_fault)
 {
 	vm_fault_t		ret;
-	pfn_t			pfn;
+	unsigned long		pfn;
 
 	if (!IS_ENABLED(CONFIG_FS_DAX)) {
 		ASSERT(0);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index dcc9fcd..29eec75 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -26,7 +26,7 @@ struct dax_operations {
 	 * number of pages available for DAX at that pfn.
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			enum dax_access_mode, void **, pfn_t *);
+			enum dax_access_mode, void **, unsigned long *);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 	/*
@@ -241,7 +241,7 @@ static inline void dax_break_layout_final(struct inode *inode)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
@@ -255,9 +255,10 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
+			unsigned long *pfnp, int *errp,
+			const struct iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		unsigned int order, pfn_t pfn);
+		unsigned int order, unsigned long pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 void dax_delete_mapping_range(struct address_space *mapping,
 				loff_t start, loff_t end);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index bcc6d7b..692e4c0 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -149,7 +149,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode node, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 374daa8..dc6ace2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -37,8 +37,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write);
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write);
 vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 				bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c5345ee..12d9665 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3644,9 +3644,9 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn);
+			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn);
+		unsigned long addr, unsigned long pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index 14bc053..b90ca0b 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -4,15 +4,6 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-
-/*
- * pfn_t: encapsulates a page-frame number that is optionally backed
- * by memmap (struct page).  Whether a pfn_t has a 'struct page'
- * backing is indicated by flags in the high bits of the value.
- */
-typedef struct {
-	u64 val;
-} pfn_t;
 #endif
 
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
deleted file mode 100644
index be8c174..0000000
--- a/include/linux/pfn_t.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PFN_T_H_
-#define _LINUX_PFN_T_H_
-#include <linux/mm.h>
-
-/*
- * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_DEV - pfn is not covered by system memmap by default
- */
-#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-
-#define PFN_FLAGS_TRACE { }
-
-static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
-{
-	pfn_t pfn_t = { .val = pfn | (flags & PFN_FLAGS_MASK), };
-
-	return pfn_t;
-}
-
-/* a default pfn to pfn_t conversion assumes that @pfn is pfn_valid() */
-static inline pfn_t pfn_to_pfn_t(unsigned long pfn)
-{
-	return __pfn_to_pfn_t(pfn, 0);
-}
-
-static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
-{
-	return __pfn_to_pfn_t(addr >> PAGE_SHIFT, flags);
-}
-
-static inline bool pfn_t_has_page(pfn_t pfn)
-{
-	return true;
-}
-
-static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
-{
-	return pfn.val & ~PFN_FLAGS_MASK;
-}
-
-static inline struct page *pfn_t_to_page(pfn_t pfn)
-{
-	if (pfn_t_has_page(pfn))
-		return pfn_to_page(pfn_t_to_pfn(pfn));
-	return NULL;
-}
-
-static inline phys_addr_t pfn_t_to_phys(pfn_t pfn)
-{
-	return PFN_PHYS(pfn_t_to_pfn(pfn));
-}
-
-static inline pfn_t page_to_pfn_t(struct page *page)
-{
-	return pfn_to_pfn_t(page_to_pfn(page));
-}
-
-static inline int pfn_t_valid(pfn_t pfn)
-{
-	return pfn_valid(pfn_t_to_pfn(pfn));
-}
-
-#ifdef CONFIG_MMU
-static inline pte_t pfn_t_pte(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pte(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline pmd_t pfn_t_pmd(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pmd(pfn_t_to_pfn(pfn), pgprot);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pud(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-#endif
-
-#endif /* _LINUX_PFN_T_H_ */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index ed3317e..cc56485 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1505,7 +1505,7 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  * by vmf_insert_pfn().
  */
 static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-				    pfn_t pfn)
+				    unsigned long pfn)
 {
 }
 
@@ -1557,7 +1557,7 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long pfn, unsigned long addr,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-			     pfn_t pfn);
+			     unsigned long pfn);
 extern int track_pfn_copy(struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 86fe6ae..1af7e2e 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -104,7 +104,7 @@ DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole_fallback);
 
 DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
-		long length, pfn_t pfn, void *radix_entry),
+		long length, unsigned long pfn, void *radix_entry),
 	TP_ARGS(inode, vmf, length, pfn, radix_entry),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
@@ -123,11 +123,11 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->address = vmf->address;
 		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
 		__entry->length = length;
-		__entry->pfn_val = pfn.val;
+		__entry->pfn_val = pfn;
 		__entry->radix_entry = radix_entry;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx length %#lx "
-			"pfn %#llx %s radix_entry %#lx",
+			"pfn %#llx radix_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
 		__entry->ino,
@@ -135,9 +135,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->write ? "write" : "read",
 		__entry->address,
 		__entry->length,
-		__entry->pfn_val & ~PFN_FLAGS_MASK,
-		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
-			PFN_FLAGS_TRACE),
+		__entry->pfn_val,
 		(unsigned long)__entry->radix_entry
 	)
 )
@@ -145,7 +143,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 #define DEFINE_PMD_INSERT_MAPPING_EVENT(name) \
 DEFINE_EVENT(dax_pmd_insert_mapping_class, name, \
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
-		long length, pfn_t pfn, void *radix_entry), \
+		long length, unsigned long pfn, void *radix_entry), \
 	TP_ARGS(inode, vmf, length, pfn, radix_entry))
 
 DEFINE_PMD_INSERT_MAPPING_EVENT(dax_pmd_insert_mapping);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index cf5ff92..a0e5d01 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -20,7 +20,6 @@
 #include <linux/mman.h>
 #include <linux/mm_types.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/printk.h>
 #include <linux/pgtable.h>
 #include <linux/random.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31b4110..3ba6dfc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -22,7 +22,6 @@
 #include <linux/mm_types.h>
 #include <linux/khugepaged.h>
 #include <linux/freezer.h>
-#include <linux/pfn_t.h>
 #include <linux/mman.h>
 #include <linux/memremap.h>
 #include <linux/pagemap.h>
@@ -1374,7 +1373,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 }
 
 static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
+		pmd_t *pmd, unsigned long pfn, pgprot_t prot, bool write,
 		pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -1384,7 +1383,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pmd_none(*pmd)) {
 		if (write) {
-			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
 				return -EEXIST;
 			}
@@ -1397,7 +1396,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		return -EEXIST;
 	}
 
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
+	entry = pmd_mkhuge(pfn_pmd(pfn, prot));
 	entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
@@ -1424,7 +1423,8 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1491,9 +1491,8 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 		folio_add_file_rmap_pmd(folio, &folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
 	}
-	error = insert_pfn_pmd(vma, addr, vmf->pmd,
-			pfn_to_pfn_t(folio_pfn(folio)), vma->vm_page_prot,
-			write, pgtable);
+	error = insert_pfn_pmd(vma, addr, vmf->pmd, folio_pfn(folio),
+			       vma->vm_page_prot, write, pgtable);
 	spin_unlock(ptl);
 	if (error && pgtable)
 		pte_free(mm, pgtable);
@@ -1511,7 +1510,7 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
+		pud_t *pud, unsigned long pfn, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
@@ -1519,7 +1518,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pud_none(*pud)) {
 		if (write) {
-			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
+			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				return;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
@@ -1529,7 +1528,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 		return;
 	}
 
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
+	entry = pud_mkhuge(pfn_pud(pfn, prot));
 	entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
@@ -1549,7 +1548,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1614,8 +1614,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 		folio_add_file_rmap_pud(folio, &folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
 	}
-	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
-		write);
+	insert_pfn_pud(vma, addr, vmf->pud, folio_pfn(folio), write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
diff --git a/mm/memory.c b/mm/memory.c
index 6b03771..4eaf444 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -57,7 +57,6 @@
 #include <linux/export.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
-#include <linux/pfn_t.h>
 #include <linux/writeback.h>
 #include <linux/memcontrol.h>
 #include <linux/mmu_notifier.h>
@@ -2405,7 +2404,7 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 EXPORT_SYMBOL(vm_map_pages_zero);
 
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn, pgprot_t prot, bool mkwrite)
+			unsigned long pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
@@ -2427,7 +2426,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			 * allocation and mapping invalidation so just skip the
 			 * update.
 			 */
-			if (pte_pfn(entry) != pfn_t_to_pfn(pfn)) {
+			if (pte_pfn(entry) != pfn) {
 				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
 				goto out_unlock;
 			}
@@ -2440,7 +2439,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2509,10 +2508,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, 0));
+	track_pfn_insert(vma, &pgprot, pfn);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
-			false);
+	return insert_pfn(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2543,21 +2541,22 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
-static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
+static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
+			bool mkwrite)
 {
-	if (unlikely(is_zero_pfn(pfn_t_to_pfn(pfn))) &&
+	if (unlikely(is_zero_pfn(pfn)) &&
 	    (mkwrite || !vm_mixed_zeropage_allowed(vma)))
 		return false;
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
+	if (is_zero_pfn(pfn))
 		return true;
 	return false;
 }
 
 static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+		unsigned long addr, unsigned long pfn, bool mkwrite)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
@@ -2570,7 +2569,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
-	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
+	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
 	/*
@@ -2580,7 +2579,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_valid(pfn)) {
 		struct page *page;
 
 		/*
@@ -2588,7 +2587,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * regardless of whether the caller specified flags that
 		 * result in pfn_t_has_page() == false.
 		 */
-		page = pfn_to_page(pfn_t_to_pfn(pfn));
+		page = pfn_to_page(pfn);
 		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
@@ -2623,7 +2622,7 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, false);
 }
@@ -2635,7 +2634,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
  *  the same entry was actually inserted.
  */
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn)
+		unsigned long addr, unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
diff --git a/mm/memremap.c b/mm/memremap.c
index 2aebc1b..2ea5322 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -5,7 +5,6 @@
 #include <linux/kasan.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memremap.h>
-#include <linux/pfn_t.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
diff --git a/mm/migrate.c b/mm/migrate.c
index 676d9cf..2de1b47 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -35,7 +35,6 @@
 #include <linux/compat.h>
 #include <linux/hugetlb.h>
 #include <linux/gfp.h>
-#include <linux/pfn_t.h>
 #include <linux/page_idle.h>
 #include <linux/page_owner.h>
 #include <linux/sched/mm.h>
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index c1ec099..05e763a 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -10,7 +10,7 @@
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
@@ -29,7 +29,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
 		if (pfn)
-			*pfn = page_to_pfn_t(page);
+			*pfn = page_to_pfn(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
@@ -39,7 +39,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	/*
 	 * If badblocks are present, limit known good range to the
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ddceb04..f7e7bfe 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -8,7 +8,6 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -135,12 +134,6 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
-{
-        return phys_to_pfn_t(addr, flags);
-}
-EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags)
 {
diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index b00583d..b9047fb 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -212,7 +212,6 @@ void __iomem *__wrap_devm_ioremap(struct device *dev,
 void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags);
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags);
 void __wrap_devm_memunmap(struct device *dev, void *addr);
-- 
git-series 0.9.1

