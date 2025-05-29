Return-Path: <linux-fsdevel+bounces-50034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B6AC78EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D753A4249D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0579325D1E4;
	Thu, 29 May 2025 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKBgH4G6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38162566F7;
	Thu, 29 May 2025 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500376; cv=fail; b=JVhJX5+e8fMEC2icWbpVeMCudgaqYWvsj3VtoUkRW0JeyU5ODzGjh33ELp7Zi11pLGBcQ2gpWI7MlMEoSTU7X8++sAfsSZMehm2RBhuRnHymKjPu+XFTZkYlKPS1HoFlmMo3z5eWMisU7K0t9FUf2r4V5p2iywdHYHn511o98pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500376; c=relaxed/simple;
	bh=I57+RA5h2TW40lyni/vab1N4L0CeU0E+bQDIXG+j5FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEFul+rr5Ve8Ivd1EYvn7DvfnKpOxb59VBWB/z+BtHwP9LmkBf++HPnd3VkTqsiXl1NqZDiWiS5piXIQUKrwDFdDcsB4nYh08xzt2R82vVxpPcXfYhZrZIpFnlHJlETUajqemyLdAKjhxaz7qAprVk1Ang9Z6xDEbvaequvH9V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKBgH4G6; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBQOPm8PWdqNguTT9QpaIuXVe5fCAV/OsxLWpijaJAWyTMxB7fqeqa/QmiwmH+4EwXbWl1WU/diJo3roBJShYQuSbz2QSlCY29ConsgJhpniol6zNUGOVn6Q6l9CgI9kMJs8G8KHBcLpSy2OvlYhS9pXZdtFSNU1oAcQT0xiJxlzuI6ov5WUTQg7882ZP6GYa9R3NVaWM3KXaXnq9IztvzGnq15en4ecAr8xgstUQXiFqlz+dC+zndoPYseqLYUMfStdm58BBWtNWwHOOKxW71212JUPQyP1XyzXByZDXUQJGVFDen18oXk7W7O00TD1L1ZCTFKGjQVo0gMHvCNb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91gm/Jxh4TMrglOkMRlti64zyK2InSmzTQDomPLMjx4=;
 b=NKxckbdw6svkEdsBWwaAEGm4jYnaBwfL21bvF0rT0y3pB1oUvsWK6daa3QJ16aZ5n4QEjnLuzPK275/MPqZvo86BVHDwlcbY0ZGmYaygo0c3BY+MThiNfGWNO5hEtmDS72e1OG3Jv46f9ZiYQlE9NHN/b+49+7+JaSmIA/1Q45NcFLNUT761FTDtPBZMwI4QxznnGaeloL+22qdPXqMJ6DXXUquhxvqA4O+EIwM1+OVnKKQ4hkTihsi0aW15ZIrJ2lrlGtKSEP/RZ06i60anzAZ0qGOHue4pcuZESV4BV6vzoDFGLFZr0iFvwXaUHbaCtRzb5LDVHxcvVu2QzqbJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91gm/Jxh4TMrglOkMRlti64zyK2InSmzTQDomPLMjx4=;
 b=EKBgH4G6iJJCT0fz0imblSXiLLCtutvSMHRUov5DujHcBI3KAEN7dj1A0KDCCE5XitHj02qbqHp43juufdbswRFW1XSEFNpGCQFNinl4ZdEVkiDrqca1w9EYfl3/Ed1UTPjHAm7FChilDmTEBkVV3SHHzxQfDvhH01fJRErnwTsP9G/zyrYYown7qQwSWepJE+4Zx0Vk15sMt4jjetMzpv2XVqQgWzcpPWUe5FQOTQSMKm43rC8y3GLIjptzCQ6c93omQLDT1N+C5Bx1/NVsLIxDOII8plzcNLTj1eAIOy9DjyoMkMU46QvoXLhHlFK1kKkDRJ//j4r4qAEzoXFdqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:32:50 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:32:50 +0000
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
Subject: [PATCH 06/12] mm/gup: Remove pXX_devmap usage from get_user_pages()
Date: Thu, 29 May 2025 16:32:07 +1000
Message-ID: <c4d81161c6d04a7ae3f63cc087bdc87fb25fd8ea.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0030.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::8) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: c191345d-5e4d-4800-1c3d-08dd9e7aa1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LH54R4rmD+kwghzpbZiuP55VMVM3rZ6mrBXpktSVedP9oenZKIyKD/VXeXfc?=
 =?us-ascii?Q?HY7iIyV/zj+cuCpPHuxYHfM0xAeS7fZCqPd58mHq74iV82QVnXhc9H+H4CJ9?=
 =?us-ascii?Q?TcfIc5tclxpyJT4WIu6IXIHWq0d6wxeth+VZabYANGIUqzM8s3BOfEwaKvny?=
 =?us-ascii?Q?WnWvgbDuli2evA45pWp61M4WfnrEeoTIELYB1b0x7AIGCg8QSP9vy+RfzRlw?=
 =?us-ascii?Q?yYrDqPQqeCqxjYj2HEqfC8dLq2Ctq4XaKjtVVXvG9RdNCZ/wBpdc97RynLDh?=
 =?us-ascii?Q?CcxHq7yiEhHMqQy09LuZhq5EP7Fsg/6e8YR38IvpEjjiVXfl40dCUNbxmPL+?=
 =?us-ascii?Q?W0OE41NhyyebAets7tfdrMKROYcMwMPzcWFKL/9G03Z9Wx7QPAfkuF5poAzA?=
 =?us-ascii?Q?ZN8ihT2Af+ZMbsuByWv8zSz9pjKzDZloPlUAl2Y4GtfaSBQC1NSTAX06K+GK?=
 =?us-ascii?Q?HrQGUsBbYa7DUsz4IiTFBK5ESzPtNic2+8bRAPkqp0+HQgsb9dqMZ0E1h6eU?=
 =?us-ascii?Q?pCw7vwyJKmdngQUSnbQlh0jD3eBb8ne9Qv2VYB9jvHhNJjF1fVfLquXOM2k3?=
 =?us-ascii?Q?+H39/YMI+dk0ZpN5vU3zaEllK31iNWHP02FwKLSfu+4YHVluEXxT5BOP9rbB?=
 =?us-ascii?Q?Bx1yg0/LTY7gmzjXboDC0RBqPLFiWYz8utfzSN5ecNtBLNZ7EgYZqVEyKhW1?=
 =?us-ascii?Q?cNnjOo0Vb9LB75CTlkvTuBYAzeZPaISr/i3dKcICdqdY6PzTsc4YA9pw02kv?=
 =?us-ascii?Q?/v5yR2YN1BOYrPfXyt6bvywSfsmAWqQCM+aMyk3FtJfQaI9srv1MAPQ6Ib6R?=
 =?us-ascii?Q?K9vQi7ew8HJmFgLwUU/qvrrMgSy58jyror/HAK7o/K5MtxFsWfXTh75GATmt?=
 =?us-ascii?Q?4DMkXNg1TMAI5TIcCHT17H+a4iGu5LXLU45ltnbS6Ofug7nWZREr2SH6VRNe?=
 =?us-ascii?Q?ySqVgydLkMdj0nfGOQoCws4UzM2CMesLa/DChUMOB7n/smQMSVROd8E46pdD?=
 =?us-ascii?Q?HxqJkkeBb6u1GC0sE5NhY19kM/xNBg51swZJfXr35G8PNtR1+8hZF4IY8Ii8?=
 =?us-ascii?Q?R/O1956g79rkgChuC6RTqgZ7JCGo7sIInZ1Z8gKy18F/ns9bl0LSJIoSK9A4?=
 =?us-ascii?Q?JB+f/drvQz9QFEFMDYsrQwSfLs3pdlsPir+/gv1gBZMo+c/gEtElexUNQPHa?=
 =?us-ascii?Q?bNmeGVByepE2fePhJEX6ZOnx07VIVR4sKWq10UAHSZ/wSQ0+Rai7qxUKp5Kd?=
 =?us-ascii?Q?Dj9nKlKJcSEGZq56magivFh0C3GyrKkWInuLSbBO+rAyhohweStFo1raQYQV?=
 =?us-ascii?Q?pEKlbFxF+UzHr4ssxFz0zNjvC6X/RZD5Bc27Kae1Bu3SF9BkHRjB9ZfGEySe?=
 =?us-ascii?Q?p40nMCTpJ+47TB1g+ZBIM4Pcz3bV2frvKgUS/ghfX/+iaOVzkxlezaPBuiiM?=
 =?us-ascii?Q?gb8lMcd+fNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDP1p35dWi7WPMjTFEAVMKnYnnyU+/nEWiUwiIYZZ8qpJvsoZIlBYdZ1I7SQ?=
 =?us-ascii?Q?y53qr8Joer+r33HPX3uqM3I1wUiAqSYjSiyuatkeVUgZ6i8XIuSJ99slu/0J?=
 =?us-ascii?Q?PX03ouhvwoeVUiWr7LiFCLUUBKzzFaownG1kdUWgm+Wuf7oJ+aZ81pYbm8Jm?=
 =?us-ascii?Q?R35hn0QE/qz5pEu8hBVBjx99k8f1k03oV2kcLgHeumBgxduRna5896lmo2gG?=
 =?us-ascii?Q?xfLvmFHI7vhdD1qC8WjaB7CNzq8Pjd3dtqCvQfKQ0suzgfDjdcxX00b5ZI+9?=
 =?us-ascii?Q?0MdbyKmsvt0eOTn3Ps6vstU4nKaB1V2grFr2aLV+WMg1Cov67pk1ES2Ah3YO?=
 =?us-ascii?Q?xg5dIbYyPK9Vcw/AeguXYN8eongdsQ2as0fr36WmGfsmM8bgpGmRtO2sMiuH?=
 =?us-ascii?Q?5yHTmvaC4TR+yXU8NhRUJzDB0WRvckXfU744wg5lVfHp+VdF2Ef6jEAWka2v?=
 =?us-ascii?Q?/bvFV16HQl6nEvCz7rPiLaiHoFgFUBkr5Ybrsy5giEV/Nxk/jVI8YU2sF+fI?=
 =?us-ascii?Q?p/0suP6QgC8pJx8NI5fvLmvxHxZDWgUJdYNvxOIBWnGCKhukZBT0Ayso1Uei?=
 =?us-ascii?Q?1npr+fxB3Pwfo3U1c3pLYpcDcNWNuQYPxaV6h/E2Nl5KPhvLjyG3vWHoom0f?=
 =?us-ascii?Q?vbUkTaZyiWqMXQIOPYDV+xJhv0LpjNGcKHfwjrejN3JBEtvclMQpVfp6HVTN?=
 =?us-ascii?Q?2tjL1N67jOd89GF6tN6/OlhWckjkzvntOp/F3tNgYb3L7MxQjYi8P2T4KVnX?=
 =?us-ascii?Q?i2wM0+fC2bEFD8sNBu9frp2IytLPjJWIOD/d+N3NkJ2ChP+QwR+Q4Z08Yk1k?=
 =?us-ascii?Q?G0SsXbdWxmPr4jAAfBi42eLCOxnom0xHefsJq4FhxQXB7yt75mVslTYgOx6a?=
 =?us-ascii?Q?jIdlKnIyp2VO7g11PfdiDVbeN8H1tC291DazQHvcIrFdl5SO0JqgYMFfpg9T?=
 =?us-ascii?Q?FihEnLIYgxtllBbFuHP84ObCEHgiBSwrLdXkytFaH0axFW/FEb4Nq3pZruTJ?=
 =?us-ascii?Q?d5ZeJthXW7p7LtwcJhKrgm33VQ1pLTq9/Gd6EYvAbSMHGQ9iZ5ehbPTUDnPf?=
 =?us-ascii?Q?duBdpjcAV7In8Qt10oC4QWjaZcshCeyMeMef8t9zChI97pz4ibY44uLEJesT?=
 =?us-ascii?Q?ZICycJeV1TArNyRAcbw58Rzf5XrCI3uBmffsMZO1ccxE2ot3ZNsmAv+a+qgP?=
 =?us-ascii?Q?n7flfEPkDzPD1ssMBb3tIrCNhSum1k2ojjIjlSBHjiOjJFCQRmWc5VNoKuv4?=
 =?us-ascii?Q?GAZ/aBg1Bc+OPjTj5vymQqSM8OwsHeWJY4mtSbT8VZmx7oZ03kffsJQHl2Ie?=
 =?us-ascii?Q?o7jUXmL4PgSMfYfkmkGofbM0b0z8yhYAQ8pEGVADKJZr4Obk3hBjM8gnRmeS?=
 =?us-ascii?Q?JrtdD/C9SFv+vbTjzeD5jcPrElFru2St5cttDq1E6TUd8Oo82P/XkABxAS7V?=
 =?us-ascii?Q?fan+BksmZyNPgVN920+9G6O34zCjLNLRcYPqYwoqInk6LjDgv1N6P3EMZMWB?=
 =?us-ascii?Q?y3I2kP8QNUxAJrxz129AIPeuxBTZMq4dlp+7G3bU1yODlFJ6yFX+sijb91Jw?=
 =?us-ascii?Q?lIarko9AIFmVFvnAQTbv05InPuUexJwXAG1dE2k6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c191345d-5e4d-4800-1c3d-08dd9e7aa1f5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:32:50.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di4KLq66PaqD+PdUBMTktL8eDWTuwiPHkNLhLPKB5b+t4bt4Lx83BEUnpMqDgqH24BDqaObsfvRPGq00aCtNCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

GUP uses pXX_devmap() calls to see if it needs to a get a reference on
the associated pgmap data structure to ensure the pages won't go
away. However it's a driver responsibility to ensure that if pages are
mapped (ie. discoverable by GUP) that they are not offlined or removed
from the memmap so there is no need to hold a reference on the pgmap
data structure to ensure this.

Furthermore mappings with PFN_DEV are no longer created, hence this
effectively dead code anyway so can be removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |   3 +-
 mm/gup.c                | 162 +----------------------------------------
 mm/huge_memory.c        |  40 +----------
 3 files changed, 5 insertions(+), 200 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e893d54..c0b01d1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -474,9 +474,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
diff --git a/mm/gup.c b/mm/gup.c
index 84461d3..1a959f2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -678,31 +678,9 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 		return NULL;
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
-	    pud_devmap(pud)) {
-		/*
-		 * device mapped pages can only be returned if the caller
-		 * will manage the page reference count.
-		 *
-		 * At least one of FOLL_GET | FOLL_PIN must be set, so
-		 * assert that here:
-		 */
-		if (!(flags & (FOLL_GET | FOLL_PIN)))
-			return ERR_PTR(-EEXIST);
-
-		if (flags & FOLL_TOUCH)
-			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
-
-		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
-		if (!ctx->pgmap)
-			return ERR_PTR(-EFAULT);
-	}
-
 	page = pfn_to_page(pfn);
 
-	if (!pud_devmap(pud) && !pud_write(pud) &&
-	    gup_must_unshare(vma, flags, page))
+	if (!pud_write(pud) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	ret = try_grab_folio(page_folio(page), 1, flags);
@@ -861,8 +839,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -870,18 +847,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
-		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
-		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
-	} else if (unlikely(!page)) {
+	if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
 			page = ERR_PTR(-EFAULT);
@@ -963,14 +929,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-		return no_page_table(vma, flags, address);
-	}
 	if (likely(!pmd_leaf(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -2889,7 +2847,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2913,16 +2871,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2993,91 +2942,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
-	unsigned long end, unsigned int flags, struct page **pages, int *nr)
-{
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
-	do {
-		struct folio *folio;
-		struct page *page = pfn_to_page(pfn);
-
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
-		folio = try_grab_folio_fast(page, 1, flags);
-		if (!folio) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-		folio_set_referenced(folio);
-		pages[*nr] = page;
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	put_dev_pagemap(pgmap);
-	return addr == end;
-}
-
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-#else
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif
-
 static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
@@ -3092,13 +2956,6 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_special(orig))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
@@ -3139,13 +2996,6 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_special(orig))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
@@ -3184,8 +3034,6 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 47d76d0..8d9d706 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1646,46 +1646,6 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	ret = try_grab_folio(page_folio(page), 1, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
-- 
git-series 0.9.1

