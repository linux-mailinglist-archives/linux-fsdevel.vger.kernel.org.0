Return-Path: <linux-fsdevel+bounces-22572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC5919C61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C7A1C21E87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EBE47A76;
	Thu, 27 Jun 2024 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CMC4zjSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15305291E;
	Thu, 27 Jun 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449734; cv=fail; b=ILo5/pcIbMLMC10j6gDVbAHc51lXTui0nMcwFqrwd6IbuCHyUZ5FoGWmCIyj3iknXHzg2x+/aabdhvkJx92Qtffjjgzn3pDsitwM0c/ybPK8LAOIeADqyGZmTGMX+Or2xol8UYfm4grIB0WkttyD0/2vgUQ73PZEQ2Vr/M/FKi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449734; c=relaxed/simple;
	bh=HUnfuK3yWB2WdpNU0XspJ919qiGK8h+3k9qruhNhn1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5VNTBLvvAB45E8CKdZANkvcrwXEjZwig/a8u78zKslCin0/mEhCiqM1KJ6p5eagazDfG4KZqx5yvh1xvnRHL7VvUldxK4xbO+HwNVSmDPUHfFiWa17US9n4eNYEMusuj1+KVJcjVCDKB/avj0IYqmArB6xL+gOY7fgq8Lti2gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CMC4zjSB; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVYOTJH20O/VfTmX+o4fAer0SlAbuTf4NU+uHjohfvcfeq4Nbiz/+QJFZY0ul3HNgVF8TRqOWC8S+5oFroHAghdUHBjVHTI5QEn1RfifC2GbH+ZkZdsavuts96Blq2mM3YpecxKc5D09lg0gt8JVFtVZZJOjdPHH9jkMrmI4giwT99iGRsENDS+aNtJeE6SW4yb9pzKXeZIFwIYIZirad6KXX+NyJm84nclEjWl5DM7mfJzKHMozzGAYyoidTOqVxRwGtlRLnKf8ZMtrCRZtXiX2nuPIeLRLk7PX50nDujinfOP12HJEMGy1rC2TnlBRq91dXOTGPEsy/14Sg1wvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG00LAug8gZSPh8zfav+ulz30+w5HyzYuRAWG5N/XZ8=;
 b=YgsLdq6x/oeS5znucmF7r01aGoZ+9jv6QK/iluctbZS5IOz2QHW+irtM5s33ngzMR3RAQW53DHdDus8GbtGPrGzyCFnm0FPH84PIAfi9fmUegUYEIhtypurSKfCW4wk/xy/IonUXojaciWddmKAXD/SgDI2jSK1jqbq1LwhI2ocbwl/gbvGAg7wLCXRMhQ+68XBpxGkyTYi9rSxY4d1X8ObNI56hFTxcDODcaDJLmEMue8tRSASIpnrw+kB6iOgv+7ZTXcElCZLVJgD+hYrhrbKP2PJkRBZmIBPJCy+Z7RSXU3p8DBlqr/YzZUODszwTgmPgiyWoDvEJGRN0LfyRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG00LAug8gZSPh8zfav+ulz30+w5HyzYuRAWG5N/XZ8=;
 b=CMC4zjSBGEIJumw/ydV9WDv8aGG6UdAMgODMWIlpDtTlivgcFnwPa4VVaR/Bp64zX+pj9Ck+sLoPxZEOlZg8X2nggM197YBAyxW8FpdBBERFPoAfT9jizYwvdyS0Y0As/VghKme4Dl+kzTkXKxv/3C/feTBD4ROaNhWjzFYRRxGAWyNBoi1cYc3csAbJcrG0nOZ1ddukMvy/mUMAvZ2unm3WgIDHj/OZU5TbWPSRwJXZOXqDPX/6ECJZM3VIbeQKxW6DTNMsOy+nZJsVGop/Nw0ps+3ZXWCE74BT6K5HSXuQTrd65kKytsDWXSMTM2p9Fb3AJWTT1CADYWaO4WhN7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:55:26 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:55:25 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
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
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 10/13] fs/dax: Properly refcount fs dax pages
Date: Thu, 27 Jun 2024 10:54:25 +1000
Message-ID: <afcfa4f164e5642c4f629c75acf794838c2ac9aa.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b4f164-f53c-43fa-0642-08dc9643d4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSqIiDV4t6/vatsirjaziHxDHAXRmzEwtwEZfJkRs8CC42PjkQnGxLb7vcPk?=
 =?us-ascii?Q?IQjSVPSdnjSafxshTe+YLqSjGkka2a+MNvNs5rjt0Ca7J95g5flXuYynDkO3?=
 =?us-ascii?Q?TN4syfBPTeVVuPXK+0n5UR0ZeXRmaBgYl3bfn+oL9YAreonYhLXi5tn8uJ4W?=
 =?us-ascii?Q?wS3ADQ6HZzCDrFpQVoA/7a2YBaD5C8z6LwIGo4RE28kARSlH3gLcXuZaOhY9?=
 =?us-ascii?Q?xJOe5LqOUU5xC52Mg5UdKI8rlz0gBtkeKj2KkHHBCMCp8bWNqzmCqIggduaY?=
 =?us-ascii?Q?z/rv8EyJNOe+xfUSgHGr/cIbQXKn/xO92FMVxjangGAmgPWUuQ5xQhFh8ome?=
 =?us-ascii?Q?d+yVgnIRUUm26dYaFTaWwOalG/7CnMkh5IfESRhNfImaNW77kEVGhQ9vcXOE?=
 =?us-ascii?Q?9QP5InqbNnB642M9qrm4c3J0FTf+1W/+rJ1lMKOdfoBYHfO1WHH7ZumYPJ6q?=
 =?us-ascii?Q?Bx8nLRxab80qOrIfTRZQrKXUF/VtlO12zR2fcun3z7goxcRoWTi8pOAzabns?=
 =?us-ascii?Q?WMzebL7zHrV1WtaWQ+12l/LNpx3Vn+NKugCeQ3qYGuuLcavG1w+Qz4NWWyMJ?=
 =?us-ascii?Q?AIBfbLu+rOxqdHLtJNNoyBF0b+2eX+bnXhOB9plIjb39PTjhZirt4BwhijCF?=
 =?us-ascii?Q?RNU70Xo8ogWXpJtzqN/JfCZYq+laIoRZfHJTpnNeVaCec0wjGQF+cWvYOS/I?=
 =?us-ascii?Q?XxYtipmVhGFLhe+EkVIsTPTPMWjvDJxwAGsYIVh6NvTMkhjgKd96PzYHVRRL?=
 =?us-ascii?Q?McgJFoyjWZacZajT4kBJEyXPz+d8BcyU7UhuG48/W117hSoFwCkr2/zwZWzD?=
 =?us-ascii?Q?yCDkXwXlw1zKTAdehE537+2ekXMq+xeu7fLjwkyYw9T029uwQHgiyaaXATlT?=
 =?us-ascii?Q?BD6GyiHteXMM0eUqviUXEvhcUo3vHW2AoJtJvPxJ7ugTGLE+WP7vVYHSwVrb?=
 =?us-ascii?Q?PoiDzvME6lXINQxMkE19BzK6ZacN+Nt2k2sXihr9pT8xwddEcibAnsyUVqfE?=
 =?us-ascii?Q?5szkwDy5eiiWU2i4EitHIvRV9sw0DsX4B1Wr7MscEli9DR9PliT+dIuDV2Hv?=
 =?us-ascii?Q?k4IJBHajft+wbSM3iwn030IggcWDY5iK0SXr2iIQn8iQ/4lc9Mf2GYmhfw7r?=
 =?us-ascii?Q?d5yJsRu1VMxes2FYQbycSZ5vK2dCdHJ6keZ02+YlRdOJVB8qMgQ7YEq3mGQH?=
 =?us-ascii?Q?7Y4Lgz9ZuFIxmJ1IP6z4YFT1HczHf/AbEfQYsm3X1Chb2ZzkVP8rqCShNMIp?=
 =?us-ascii?Q?spoxqniGLF2xCYn9TqpD5lqTxs/5WBVT3G2jka9ER3yeR0yg6GBrpbrvr4SS?=
 =?us-ascii?Q?2v13PGuk0yu41Vae5NjWtYMcWlQ7BuzeFAyRuXl36Nu26w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8TZBUxD6ng0a076+OlBBHJvq3ROL7ZX68rakj/kjLalNhghvpun/up1ePk7?=
 =?us-ascii?Q?xnYrVGaQWRymLxYCguPCNM6WtwItAljYAF1OFunwhfUpTngS83wCjWSO0TKs?=
 =?us-ascii?Q?r6J+X5x0aKYs9bqZts/21Pj6n5l+TigXmx7qZRWUpwOMs6jQTB8Q/MmTlLvZ?=
 =?us-ascii?Q?0UDcUb/cPZMQ3Ew1mjZKloQPC2Ao5P60yqYeMVKwu9M/eFv+g0ZMvAYCiKsB?=
 =?us-ascii?Q?ersxPh2K3u5UYykB4adKe5uQCJ1QoYwQYXUSzqdBqw3JIJwkXvbVS2+qFSwf?=
 =?us-ascii?Q?zvjTl9uT8NGqk0JrgCemCNWvhvDuPyZGyLaVfgoa5O8O4RY38TVzNz9OngAN?=
 =?us-ascii?Q?7yCNFLpln2jkKmRhlNVByrVQ6ygsZSGm8OT7X//yBpGbWcMJ7tx4C1QGOr67?=
 =?us-ascii?Q?lpf2YFBCUcz1+i3l+KHzohyWk95tbgapayk5VqEbiHoidnVw1tIDo35gbiwA?=
 =?us-ascii?Q?IromkEYMkXQoeYe4xQNBUoCtxsPpB6qC1EgvoDuNIgXzr9RnKW18ECMCUXxr?=
 =?us-ascii?Q?4eMXjq0ZuYUpT4xsna7jrRFN1h2jcIEc1gmWKqo+mz9xRCmZmQVhTNaIzdpi?=
 =?us-ascii?Q?2JkBVnMLaW6/GEyOdAe588AXmOXtwGWXGrmRHwmJjrFHKh2NstGfV3Z2wXo0?=
 =?us-ascii?Q?HzD1VsBVqHJpmrJ1VJoouOmhbiI3HRAoOAtfXcCraCvLq2PBUrUshGtXYIVV?=
 =?us-ascii?Q?xcNI0tdBvzKf0pNl+JLWErpEDDLXFttieURSq0oNzv2ch8lhltyt+UsFRlty?=
 =?us-ascii?Q?q1R2y2K4jgPQzeJLRX+M1/b1MuEO072hy9JsHlUjaNU3NoGVVq5jT4bwVli0?=
 =?us-ascii?Q?FQD03pH/tURUXtmVO+pTMVdCTWvFb76RVc5bYaukGgdwiAV9nJu5dB31Pli3?=
 =?us-ascii?Q?LBdo1wNsKvE9N/VIXP7ib4pK7HckKkX4xtkxcA/q/bDNUrB3NEY4eyiz6xf/?=
 =?us-ascii?Q?l2X9XyxRYY1z2AImhOvJeB6r+GqFjHA5r9JvvuTaxNyMfrbnzytLtlmUz6Fs?=
 =?us-ascii?Q?TWSjloeAV9Q1jrLh9GtolP3uRraWu0RrVSPrGKYFz4W8VcIyJu4m4UMRq5BQ?=
 =?us-ascii?Q?uP0v44J9yjf6jSnv4Lozbjw27iyc24sgXIRMLyPqZvUdlz9GBUelaAFmnW5R?=
 =?us-ascii?Q?EZM/xoEK0ImUivK7x7aSwGQVSa/v9LqPmv3KNot+7v3TneGLc/ZrAfk4+XCe?=
 =?us-ascii?Q?Ii16k2D1cib7dFhPhe8/OPTPLVqdwJl15iAGl8hXEzbrdJJpTCnQVSBn8onF?=
 =?us-ascii?Q?WqkdYpQGvXHBtr/ICSV0VI/soA+bYzpNi9f6TuslayoXItFqiJPd9oNMXeW6?=
 =?us-ascii?Q?ROwUS9UfaCkH5TofcRXc6ZEELZRP7Kk2RP04tCJEtvDaG+N8oqc78XJkJQR6?=
 =?us-ascii?Q?tyvxIRxJjzYO3GQBP1rOjn+iJc7b2tWvMJ309KCMIRmcHTpsp3rMZe2fFUGO?=
 =?us-ascii?Q?CSZxQ9IefuLm50CkdedunVmCQvEBzdINC5YsFCCr/ZJfyfRDCKCi3a6jgffW?=
 =?us-ascii?Q?+4nGFxzHVeuGQ49mKMJ3vDdmxNpIlkW1Pvv18bQMsxHO5bQOxqKZzRTS9JPf?=
 =?us-ascii?Q?v33ZxpMTKSAIQZ7kqaYZ5Xph+AJVAtpQNn6ulaGy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b4f164-f53c-43fa-0642-08dc9643d4b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:55:25.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25o7sXACLvNO7sCPoAk0Ug8NOBlETBPZWGc71kVBUzotpZ5cL5ioCLrOcQ6YQzOKDW0FEXb3WU9itrPVFNmw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

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
 drivers/dax/device.c       |  12 +-
 drivers/dax/super.c        |   2 +-
 drivers/nvdimm/pmem.c      |   8 +--
 fs/dax.c                   | 193 +++++++++++++++++---------------------
 fs/fuse/virtio_fs.c        |   3 +-
 include/linux/dax.h        |   4 +-
 include/linux/mm.h         |  25 +-----
 include/linux/page-flags.h |   6 +-
 mm/gup.c                   |   9 +--
 mm/huge_memory.c           |   6 +-
 mm/internal.h              |   2 +-
 mm/memory-failure.c        |   6 +-
 mm/memremap.c              |  24 +-----
 mm/mlock.c                 |   2 +-
 mm/mm_init.c               |   3 +-
 mm/swap.c                  |   2 +-
 16 files changed, 123 insertions(+), 184 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index eb61598..b7a31ae 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return dax_insert_pfn(vmf->vma, vmf->address, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +169,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return dax_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +214,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return dax_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index aca71d7..d83196e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -257,7 +257,7 @@ EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 {
-	if (unlikely(!dax_write_cache_enabled(dax_dev)))
+	if (unlikely(dax_dev && !dax_write_cache_enabled(dax_dev)))
 		return;
 
 	arch_wb_cache_pmem(addr, size);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index cafadd0..da13dc1 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -510,7 +510,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -519,7 +519,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
+		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -529,7 +529,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
+		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
@@ -547,8 +547,6 @@ static int pmem_attach_disk(struct device *dev,
 	blk_queue_write_cache(q, true, fua);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, q);
-	if (pmem->pfn_flags & PFN_MAP)
-		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 
 	disk->fops		= &pmem_fops;
 	disk->private_data	= pmem;
diff --git a/fs/dax.c b/fs/dax.c
index f93afd7..862af24 100644
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
@@ -318,85 +323,51 @@ static unsigned long dax_end_pfn(void *entry)
  */
 #define for_each_mapped_pfn(entry, pfn) \
 	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
+		pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_page_is_shared(struct page *page)
+static void dax_device_folio_init(struct folio *folio, int order)
 {
-	return page->mapping == PAGE_MAPPING_DAX_SHARED;
-}
-
-/*
- * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
- * refcount.
- */
-static inline void dax_page_share_get(struct page *page)
-{
-	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
-		/*
-		 * Reset the index if the page was already mapped
-		 * regularly before.
-		 */
-		if (page->mapping)
-			page->share = 1;
-		page->mapping = PAGE_MAPPING_DAX_SHARED;
-	}
-	page->share++;
-}
-
-static inline unsigned long dax_page_share_put(struct page *page)
-{
-	return --page->share;
-}
+	int orig_order = folio_order(folio);
+	int i;
 
-/*
- * When it is called in dax_insert_entry(), the shared flag will indicate that
- * whether this entry is shared by multiple files.  If so, set the page->mapping
- * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
- */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
-{
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	if (orig_order != order) {
+		struct dev_pagemap *pgmap = page_dev_pagemap(&folio->page);
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
+		for (i = 0; i < (1UL << orig_order); i++) {
+			ClearPageHead(folio_page(folio, i));
+			clear_compound_head(folio_page(folio, i));
 
-	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+			/* Reset pgmap which was over-written by prep_compound_page() */
+			folio_page(folio, i)->pgmap = pgmap;
+		}
+	}
 
-		if (shared) {
-			dax_page_share_get(page);
-		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1) {
+			VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+			INIT_LIST_HEAD(&folio->_deferred_list);
 		}
 	}
 }
 
-static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+static void dax_associate_new_entry(void *entry, struct address_space *mapping, pgoff_t index)
 {
-	unsigned long pfn;
+	unsigned long order = dax_entry_order(entry);
+	struct folio *folio = dax_to_folio(entry);
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
+	if (!dax_entry_size(entry))
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
+	/*
+	 * We don't hold a reference for the DAX pagecache entry for the page. But we
+	 * need to initialise the folio so we can hand it out. Nothing else should have
+	 * a reference either.
+	 */
+	WARN_ON_ONCE(folio_ref_count(folio));
+	dax_device_folio_init(folio, order);
+	folio->mapping = mapping;
+	folio->index = index;
 }
 
 static struct page *dax_busy_page(void *entry)
@@ -406,7 +377,7 @@ static struct page *dax_busy_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (page_ref_count(page) > 1)
+		if (page_ref_count(page))
 			return page;
 	}
 	return NULL;
@@ -620,7 +591,6 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrpages -= PG_PMD_NR;
@@ -743,7 +713,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -757,7 +727,6 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
 	mapping->nrpages -= 1UL << dax_entry_order(entry);
 	ret = 1;
@@ -894,9 +863,11 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!shared) {
+			dax_associate_new_entry(new_entry, mapping,
+				linear_page_index(vmf->vma, vmf->address));
+		}
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1084,9 +1055,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1189,11 +1158,14 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	struct page *page = pfn_t_to_page(pfn);
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	page_ref_inc(page);
+	ret = dax_insert_pfn(vmf->vma, vaddr, pfn, false);
+	put_page(page);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1212,8 +1184,13 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	pmd_t pmd_entry;
 	pfn_t pfn;
 
-	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
 
+	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 	if (unlikely(!zero_folio))
 		goto fallback;
 
@@ -1221,29 +1198,23 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
 	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
-	if (!pmd_none(*(vmf->pmd))) {
-		spin_unlock(ptl);
-		goto fallback;
-	}
+	if (!pmd_none(*vmf->pmd))
+		goto fallback_unlock;
 
-	if (pgtable) {
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		mm_inc_nr_ptes(vma->vm_mm);
-	}
-	pmd_entry = mk_pmd(&zero_folio->page, vmf->vma->vm_page_prot);
+	pmd_entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	pmd_entry = pmd_mkhuge(pmd_entry);
-	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
+	if (pgtable)
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+	set_pmd_at(vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
 	spin_unlock(ptl);
 	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
 	return VM_FAULT_NOPAGE;
 
+fallback_unlock:
+	spin_unlock(ptl);
+	mm_put_huge_zero_folio(vma->vm_mm);
+
 fallback:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
@@ -1649,9 +1620,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
+	struct page *page;
 
 	if (!pmd && vmf->cow_page)
 		return dax_fault_cow_page(vmf, iter);
@@ -1684,14 +1656,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	page = pfn_t_to_page(pfn);
+	page_ref_inc(page);
+
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = dax_insert_pfn_pmd(vmf, pfn, write);
+	else
+		ret = dax_insert_pfn(vmf->vma, vmf->address, pfn, write);
+
+	/*
+	 * Insert PMD/PTE will have a reference on the page when mapping it so drop
+	 * ours.
+	 */
+	put_page(page);
 
-	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return ret;
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -1932,6 +1911,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
 	void *entry;
 	vm_fault_t ret;
+	struct page *page;
 
 	xas_lock_irq(&xas);
 	entry = get_unlocked_entry(&xas, order);
@@ -1947,14 +1927,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	page = pfn_t_to_page(pfn);
+	page_ref_inc(page);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = dax_insert_pfn(vmf->vma, vmf->address, pfn, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = dax_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
+	put_page(page);
 	dax_unlock_entry(&xas, entry);
 	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
 	return ret;
@@ -2068,6 +2051,12 @@ EXPORT_SYMBOL_GPL(dax_remap_file_range_prep);
 
 void dax_page_free(struct page *page)
 {
+	/*
+	 * Make sure we flush any cached data to the page now that it's free.
+	 */
+	if (PageDirty(page))
+		dax_flush(NULL, page_address(page), page_size(page));
+
 	wake_up_var(page);
 }
 EXPORT_SYMBOL_GPL(dax_page_free);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6e90a4b..4462ff6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -873,8 +873,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index adbafc8..02dc580 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -218,7 +218,9 @@ static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
+	int i = 0;
+
+	return ___wait_var_event(page, page_ref_count(page) == 1 || i++,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d1cdea..47d8923 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1440,25 +1440,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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
@@ -1573,12 +1554,6 @@ static inline void put_page(struct page *page)
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
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078a..72c48af 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -682,12 +682,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
-/*
- * Different with flags above, this flag is used only for fsdax mode.  It
- * indicates that this page->mapping is now under reflink case.
- */
-#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
-
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
diff --git a/mm/gup.c b/mm/gup.c
index 669583e..ce80ff6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -89,8 +89,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -156,8 +155,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
@@ -198,8 +196,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_folio_refs(folio, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a9874ac..5191f91 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1965,7 +1965,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2557,13 +2557,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
index c72c306..b07e70e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -637,8 +637,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d3c830e..47491ef 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -411,18 +411,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
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
diff --git a/mm/memremap.c b/mm/memremap.c
index 13c1d5b..2476aad 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -485,18 +485,20 @@ void free_zone_device_folio(struct folio *folio)
 	 * handled differently or not done at all, so there is no need
 	 * to clear folio->mapping.
 	 */
-	folio->mapping = NULL;
 	page_dev_pagemap(&folio->page)->ops->page_free(folio_page(folio, 0));
 
 	if (folio->page.pgmap->type == MEMORY_DEVICE_PRIVATE ||
 	    folio->page.pgmap->type == MEMORY_DEVICE_COHERENT)
 		put_dev_pagemap(folio->page.pgmap);
-	else if (folio->page.pgmap->type != MEMORY_DEVICE_PCI_P2PDMA)
+	else if (folio->page.pgmap->type != MEMORY_DEVICE_PCI_P2PDMA &&
+		 folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
+
+	folio->mapping = NULL;
 }
 
 void zone_device_page_init(struct page *page)
@@ -510,21 +512,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
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
diff --git a/mm/mlock.c b/mm/mlock.c
index 30b51cd..03fa9e9 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -373,6 +373,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (vma_is_dax(vma))
+		ptl = NULL;
 	if (ptl) {
 		if (!pmd_present(*pmd))
 			goto out;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index b7e1599..f11ee0d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1016,7 +1016,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 */
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
 	    pgmap->type == MEMORY_DEVICE_COHERENT ||
-	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
+	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA ||
+	    pgmap->type == MEMORY_DEVICE_FS_DAX)
 		set_page_count(page, 0);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 67786cb..041cda6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -983,8 +983,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
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

