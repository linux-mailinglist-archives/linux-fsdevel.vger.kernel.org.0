Return-Path: <linux-fsdevel+bounces-35519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F29D576D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCA2282F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D1215ADA4;
	Fri, 22 Nov 2024 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0DXHulI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FE18990D;
	Fri, 22 Nov 2024 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239720; cv=fail; b=j7ZLiH87t4zDbqbzxr1QVvTvCGfYx1qw4mJbEqtexxwSkAsSTN3Tl95OzF1D4adPCMkuXci1EeuDdIbtZUCFiiwM8EOPNGoW9X+FHcwTmjAZltuz1cU2qkuwhOjOLD2TyitlY9OPsdEoCRSi+KHok4wAK5jzcblHcTB7T1dPv9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239720; c=relaxed/simple;
	bh=3BM3Zryn5BD2q0zRtbNas0SwqZfEJ5/aGK6S0dUdGnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlTBgiz81g/yB2Kh2oXr4UyH/u41Lf7FsnG8GXlF5AabCo4hNZZPGGPjzNl3DMT7y8+ZdjojS4UL3UjwaBFvmNL4gc9WoiznpjQD0EqzVCcr2zA9XPyWq2rJBRoMRWLD7IeBXvoUKCohQLYs5I1eqBMV9t/YdJ9jhRWvVuWbVvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0DXHulI; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvSsFWVpCDcn3DXD8tYh4PKczkIgdcMaO7OD5+SxO7bBJImgK5If7t5ZXd/M+hXSrDBuoMfSve+Dh97QyYGHSXgrNDqwOD/ElmqIVE7rWwNscotP0CfLLHdQa6goOX820mfTRhCZuC7+gxezsU9LXH2BxrlWxrSUU8v4jGGfq/F3eI3spSnSNtaOaTOfuheKlT/F2P90ECI6izLGQdBU11b1NK4/Am7PA+thltE5d+vYQi2q5SVOAwTLl18k7bvq8l/mEmgm03gh8yEpzXRROiAze3V3zPp8G1uXwoImH+LLLqwlFDfOc4hJnMRjYBYKAXna7e6z6G27obebqkzFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESy7x46loh4IEoR5LJkN4qdt6dpTfnJr5eSjyPduQ/Q=;
 b=kdTZN3CvNoxTygZDF+0Z3BhZEZq49KDu+TkrfN5voeHRP8BXzcEL6qTfXiIcyDiaSx4k/wR5zPlJII0W0KFoKlcjvTbPGH78+/SH5z8dT44sYmjA7Aqj0LELQSI6qnq86uWLcNb+BtHb8ost7BM2HMPprA1lqDrylJTQJjq1my4YDLaMpJ+J7BUr6Yy8KRJ4x2YVo4dchTludjvcP54Ly/nzuEOIbEMiREA7/aAOdau8Gj5yJSj7H3/g/I1182uTc3QMhrLVtbrnshDLa+sLvyskLaxkzMAAPMDF1EYoX6T/DUzdpeTRUlQY5Hh5XITWHtvGhpf3SxEv1d+NV7AvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESy7x46loh4IEoR5LJkN4qdt6dpTfnJr5eSjyPduQ/Q=;
 b=Z0DXHulIaXHnocHapL/4RkNKv0vd841JpCLXuYJTP5JiVnH4jU064lFe9X1DcYZKQ0ThJdGLFcwHRXqZJuSzd4eo/+nRz1Zz2c67475OaCbykQGpxcfwQNTz34H1nt7N8yhUbfSAbM7TAqRgZ3WOAGyrhU2nUs7gYa8VH6qsP9lKYA3WsU2b1trD38DZFwUTqC/zAHcM9evlkWmpyeci0urR9iS3dCcYholdtPp6JSLzMnNPYxa7B+Vt1mTBv3gYbWoh7a2VTFUBN5LrS4NCrL93ULyFWP6Rxe0sbND1wHPKLvLE+My18iP3PS32vz+01gGlYCcVdNgljMdQn6xLvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:55 +0000
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
Subject: [PATCH v3 10/25] pci/p2pdma: Don't initialise page refcount to one
Date: Fri, 22 Nov 2024 12:40:31 +1100
Message-ID: <27381b50b65a218da99a2448023b774dd75540df.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0107.ausprd01.prod.outlook.com
 (2603:10c6:10:246::23) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6702c7-2253-454f-780e-08dd0a96d8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAzer2QAd2rCsPipO8VaHOtjoBkhfWVCEAJeqKdWioOKNMg9GfbgNwvi+Y2l?=
 =?us-ascii?Q?KGX5bfcN381QeVg6wRE7ULK/ArbwzEi+e/WZ7OxtjTkr9qxovFvmZWbtxv8p?=
 =?us-ascii?Q?Nyt0rqtfz2VmNxey67D5/C0M8N5tXYfwtAzTmqQEYzs4A1oIczpusZ9qwV0k?=
 =?us-ascii?Q?ZsuQlwPCmogUrrUEFudCimM7ZTb8gXw7Rulsd7IG8I8wD4mnrbyIw44yPy5v?=
 =?us-ascii?Q?HH/oWBbOnvmMjpDpRRYxBNNb3xjjmiu8RjDk0+h3ANRjoUFzfv8Cs7XpyvC0?=
 =?us-ascii?Q?aIBEn1etYz3qjGT20YQ8r4tyf7KBtYDIiYzE4/YvApUHG/WQDOVqbxSL/xEW?=
 =?us-ascii?Q?xWXafrNBrBNolQkX3G9VCdxtzL4LsoYO02RLGuOngL73JYjVe2lyFogkM8XO?=
 =?us-ascii?Q?vrT0DVM6sZFVsW1Mm4+G3kq2Lzp3Af0iK59Ptoo7NRZponcv46lm1v+KP7pF?=
 =?us-ascii?Q?pSyMbc6WYJ/m+5dmLfV/Wr3ruzAcRfDWgLXEN9PgYUsJiT/tdFzWspicfXps?=
 =?us-ascii?Q?j1fpp88sG1ed0oloVo3C1F8dZL6RhuUXCqq0Yw+ImKS8bi+f/b3d/x3SkT2d?=
 =?us-ascii?Q?8c/+CJSuSB1KB6SPoDwIhMj/06iZjuK/T/FveUXTYz/1vDosNmQbMwXZzqCh?=
 =?us-ascii?Q?4wdPSJqevthT88s6y2/GpIEZSibDATe0eIi5S3P3WoV6ocKxzjy5ExMxatCY?=
 =?us-ascii?Q?uLcfX5SLbUvrYrNK9dOJgx+C+3ZU/UGpF6Psld4asEU3zcKFBuBRBrqtdpSQ?=
 =?us-ascii?Q?gdXhI1TY8hQ2UPaUG2Lv3SHVvRs7lD0sb8Ae81mQS9E4Mct+LprvswsM1jF5?=
 =?us-ascii?Q?M9dFZwIYzrrgSWLbXrU/8BHUzV3ZSGcZMy/SerUsPa8P9vQZE5ZZuePMeSDh?=
 =?us-ascii?Q?5kH+2ycZ+RjoKqtH3qQb90s0Z63TY+uRg6abVHIJsvi8eXqN2tP/v3drDAjA?=
 =?us-ascii?Q?qkf/v3jYW4fLInbDQCqn542yxmVRmXpLnySldJ+TuFnYcbQdQNpHOvGhPBTA?=
 =?us-ascii?Q?UFrgxNWHiMcMZyu8hxXcdqCNNPgPRdGDlv/daNstUyS2Rx6BvkUqyBRAljog?=
 =?us-ascii?Q?oZIjpCakBd89TGkY42dgqHeZeFTZgCTfltGrvM5UJKFLOBRv6JNC7hxLjExK?=
 =?us-ascii?Q?bX4CgCe+JPF3jzVwHVzvKjgjv7V8fYWD0kCQAyvjda1ZtD1rBjH0zOBWz5JE?=
 =?us-ascii?Q?yWqEGfpr0BX6+IEep/aBdI3I6O4CkgBMRc1puGSnst+kLcflnBsZD2PY/VCW?=
 =?us-ascii?Q?EHX4JwukQxBdpg0NSnHnLdZ640cLiy7+T1OSnbwU2U80rwvxITmb0wHRe2eu?=
 =?us-ascii?Q?FkI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ovEzYvTYrcZpUogth9ZSNVD7lRTF9lR3Nlbfaev1FSK3PsvDX3qpVUs/2VzI?=
 =?us-ascii?Q?mFev4QyEZmodhJD3qUc/Gvkghfp733lj8kdPSn47fIFgwLWo0AFjf2rmfCGs?=
 =?us-ascii?Q?A+anCbm4VFLWylQeVJbpQV2hHgwib7X2INBQ1DlQD7C3OVDxKN4pvZELU5Pn?=
 =?us-ascii?Q?/y0APV9x2ux1zAc/M7dlsT0/wpkB5RK0Bm3VSZpzFduYcWOZI8/SC2qlZMQ3?=
 =?us-ascii?Q?tCjQ41UzGCYLYuHMvx9YRfkgvCjJSQY+TlnQMG2AqHeDI1uLcm3gHJ9WNSbu?=
 =?us-ascii?Q?oTEl5Co5XsU7jHfOTnOXFz4qXR92dzSzo2qq6+kmji2dz3e2QGgsRCzlWzeE?=
 =?us-ascii?Q?Ep12WW6/7EkjqiAjlVq/A6zn7C2+LdWeQrNpK3KWNIZtuSWdP9P1+jtltlXY?=
 =?us-ascii?Q?CyaCxvkZoNJ8laob6bxzvKnjCumtb4Zq0wy6H3W/25W6jRFS1SRK4z0qP5db?=
 =?us-ascii?Q?hyIy5O5wHfcsuP7F22G4Utr73dsJL8hSZUl5HtDb0V1wPX1X23RRaqyQW/8S?=
 =?us-ascii?Q?LSTphKP58awxdtntLHfL4FHIgLxF4BOoivslIKON6vZ+axURmRhfBolN+xfD?=
 =?us-ascii?Q?FI0EOcKMy5HLgca9kXbD70eZgEcEa8Dm5Pqex8V14nnYIAGj1jj+fcUo3J6L?=
 =?us-ascii?Q?xPi3QB6BeW9qWS3fBWkTlQwLvI8X70ttM3qAppE/ZAmReFuaonwt060dxNki?=
 =?us-ascii?Q?iqRDVRkYkJigTihym0JHsdFTcfvlZ9hfzCRgX9dgyWYkAew0QLyHThmFn5q6?=
 =?us-ascii?Q?arX2bJ8u4eQytjDr+q1AnIfW2/27dyI2jSocq24pTk7zgSEWzCqmWNsIaGpD?=
 =?us-ascii?Q?IsQbfAXEwapbKEDhop+p24YQt1pgMTmH7nGswjcTUQbrvwo3srtMLkorBE5G?=
 =?us-ascii?Q?XYWYRWPRwvG/aPowC8eY5xoFKYjPVVzo+gsgOiaUQ/HPNmESP/zbQBy23Lnv?=
 =?us-ascii?Q?dHEOweIE9ayzZf6Aa9WeM+6EXN4382Qx7zzMiCY/OOOHgpXiYMbFsozbvvxK?=
 =?us-ascii?Q?0JkEJAxuZglZQWPA6ecozgIDWH9H/1xBrrqohFv9YfI0FbHkXXyVSn85MAph?=
 =?us-ascii?Q?LALzO0KL6A+1SUefiDWWsEtLWel3Ps1YScOXJAUTWC+V+AbXqL7A/lxwqNZl?=
 =?us-ascii?Q?e+Y35rFcz83z1w8qx3lp4j9BvrRahfy5WJSBjw3hSCb5/+DTvU+G5vtmj79y?=
 =?us-ascii?Q?A4jmoQTYaPTTA83YL4id+4p1Ejs37Vn2ebkK9FDC/83rieZXvLqnW8VjT85J?=
 =?us-ascii?Q?St7HJ/Z77bfO5/EjqR+pSoWuDeRXO/NxAdANZZkN0vV6UIT07vGTuomAtZDb?=
 =?us-ascii?Q?aXXDP62AhbxNzDAOymE0c94sQCOrvx/sPSPgZdZeK6ZxdbXfztmxR4kw9v4s?=
 =?us-ascii?Q?J0jA5Q7GRQD6D/csHTveYtKyxtk1yp3sFFTpTMRkoJrVauVXsxOW4S0IrWcv?=
 =?us-ascii?Q?ryMEgCuroAzLaDphMVfi7EOJISm4ErjjoorSbnk9AsJV0lPj7vC7TtsDgKFs?=
 =?us-ascii?Q?qRl7Jo2meINTQEwlqBBVZKnFOXArZQqV0s0gd/qopVO93xE0hA1DzDdSwMDe?=
 =?us-ascii?Q?xNg0fR+jw1J4+dxFUkjYysBSl4a5mbPyGUtRboEq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6702c7-2253-454f-780e-08dd0a96d8a1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:55.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7S7vTYjSjo4WhSh/8ji4NUilaH21lz8ZDp+4PyOyCA7vOI7JQlsNI1b6H5L9+3wv6DZi88+bPQLF8Lmin/F0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

The reference counts for ZONE_DEVICE private pages should be
initialised by the driver when the page is actually allocated by the
driver allocator, not when they are first created. This is currently
the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - Initialise the page refcount for all pages covered by the kaddr
---
 drivers/pci/p2pdma.c | 13 +++++++++++--
 mm/memremap.c        | 17 +++++++++++++----
 mm/mm_init.c         | 22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13..2c5ac4a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -140,13 +140,22 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	rcu_read_unlock();
 
 	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
-		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		struct page *page = virt_to_page(kaddr);
+
+		/*
+		 * Initialise the refcount for the freshly allocated page. As
+		 * we have just allocated the page no one else should be
+		 * using it.
+		 */
+		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
+		set_page_count(page, 1);
+		ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
 			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
 			return ret;
 		}
 		percpu_ref_get(ref);
-		put_page(virt_to_page(kaddr));
+		put_page(page);
 		kaddr += PAGE_SIZE;
 		len -= PAGE_SIZE;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..07bbe0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
 	folio->mapping = NULL;
 	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
 
-	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
+	switch (folio->page.pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
-	else
-		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	}
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607..0489820 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1015,12 +1015,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
+	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
+	 * allocator which will set the page count to 1 when allocating the
+	 * page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
+		break;
+	}
 }
 
 /*
-- 
git-series 0.9.1

