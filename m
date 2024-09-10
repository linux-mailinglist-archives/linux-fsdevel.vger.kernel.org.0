Return-Path: <linux-fsdevel+bounces-28975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4719727F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5CC285BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0F189BA6;
	Tue, 10 Sep 2024 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZxE+uGPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E132168C20;
	Tue, 10 Sep 2024 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941713; cv=fail; b=Daawfk1wi3RQzvWg2q8B4WFbKiepgKfyNopPp9na98ZRN6OEv3tJxwSayOHjwnOsd+ctfiwcM59NzispbtX5Fk/OnGEb2zGoJgzB6OTfX5XoDxD1ZP8NY5bJF8ZWqJcCjPJyw9m6dIXtJTbGuF00GODXbYrr3lpuQhrn49h51Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941713; c=relaxed/simple;
	bh=zW/EczAAHj8VYW5kjAxCsQDWDGQ/+6AhzihVni2zQf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLQZ9JrLkjofOLKS+/hslhJdY9MuzSNpeK4Dt4n3E/Q7SkRq8KH1z2sxQWlqVaoSAvf07F+jFux/iYfbRffiN3CkgLOej23Wq0FiIzuCOPNi5wvfVhkQ+kYRW0UiD4mWPWKLp03r6wpKSdsNGH9vcwmxYKcMdP4r+t+3QZYyKUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZxE+uGPn; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2SozdAz0QW77S4Bhen0zVnlZiEc0HshNK1GWuqMEiYPUoRt1pYfO1buoRti9bMy1Mt2ACk6p26eJm9ovnB33Sr4cRrZIBKewtcVIbkW7AxRBOzVj8B8lcimsq0nJSquvnk30zEf7eQ+4OSzw6se+khh6SiwAo/nZTfevxElHwEVHiPO5E+XzM+1R/KQFAMrlAowGJPqDd9Cxkr5daAyQclsIfW7f38kb08zSgoWs/fu7X41abFsVh+/qpiHvP8Rl0nXZpVCSK82cyD8MYYM4ZY0bSl55TKqU7U4R5+7YWudPXyMBjPqNzWI+xMghpfq6qgmPaTq2EFXfV6iaAY/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcVLiuWZMyEaidTz8honbOf5KmaLeUplBoucWssgGrM=;
 b=QH4FkoYmzX9F3/OmPMSfLp5aJZVueAyJjoMsPcbGP7xb3w6GmPJdK7JWOHZ3hY+Jr/Xbw6HX56YXw2i7YZCN5zqm933Om+cBtJC73TnWYrHV78GdOqQlwHM2O16uVVTcONpvpGpgjgjK9Grn5mInE4S+LSN7fUjW26GYf9a563j2RqEl5CKFN+Qd0D+FBFDQa/E5wG55Wup8byTYd7dZZ00kpTr11v8ExpD2MPsucpOIzRxTZeFrDej04d2uDEiVzwv46z505ikkQvR3QRVq4g9GFhxy5NJbqTmKjYhOav3KxLjQl2GDoKyWy9ZZ0aNq1Fq4xH+Lr41rtys0x+NKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcVLiuWZMyEaidTz8honbOf5KmaLeUplBoucWssgGrM=;
 b=ZxE+uGPniGIgT2BiDLKyfJcnXdqtBsRz2bLD8IzpIPtqgV4/5hcCPhVbvMR6AmfX0IZiHDSVmcfx89opEcc/7I8C+tUObMm/7YmFwls5CkM8HeVnW5iBaLI095T8BaQgDK5muSsDahrJWDmG7azWT537paZpARkjnvJVNeqha4Cwbec2XJ7At/H3TWEZAO/UemappX351N4dqzgDBd75tXby72MzOwgPvlBbiBXRfyEF8e4Qrs4KxTruzXWPs0OUGr/R9s+NSveq350yYVaRJC0sN2Lej4fldEDYZyaD6fdJOrFK3VuuKZmY23RT4D726tLbSqTydKNYiHKX+1/dfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:15:08 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:08 +0000
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
	david@fromorbit.com
Subject: [PATCH 03/12] fs/dax: Refactor wait for dax idle page
Date: Tue, 10 Sep 2024 14:14:28 +1000
Message-ID: <b77b3b3ee12049a9c7cbe64e4a117295a6d0d5c9.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0134.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cb772a-8d46-480e-5af6-08dcd14f27e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqrbVvURPQEAKv3k9135doCKU+t/lEH0CJVPgHV21AOQ3++/eXpr3/QSqvEK?=
 =?us-ascii?Q?iDeC8sGe1xrf9efOOjAaOc+rJg274pfGqHRI95A/0HuG3F1bJ9haAMVWT77I?=
 =?us-ascii?Q?GMDDUTPTHES7mIQBy8fxHDSAxFk8dTxLkZo1O1Y4KdQQE30+CbiYP2HaQwyJ?=
 =?us-ascii?Q?scC77gugvNQKDYIwbJMwey+qbcdg/VNfuymnDaflbF+UeymRBVdDCNgogIJF?=
 =?us-ascii?Q?IE0tkhNNMmM59LrlMin6EdVwGX6fPwAh4CGBU3bNDBvexTUP/DiZn1xBr3qc?=
 =?us-ascii?Q?uS1Lv94gt5scgDuuggPpz0yvNPbAKHtk33Xy1VFpgqxRuhFvcsZ9DI6jCTn4?=
 =?us-ascii?Q?q775A3EqvStJCoo02YQbHqMaQG1DUtX85JWq2Slxaz5nIT6aH9ZFVBJJN05S?=
 =?us-ascii?Q?ySHt4NRTZJITeVAnMr8VPvM5LK4BlyZIlh54+7UmL5SEzhTnlmnyYhXV1SSJ?=
 =?us-ascii?Q?7ZG3I8mEAdfPO3FxR/9bq9t5aXgxmpzKClh7XSDwiZK9tRExFJ6GUVq9x17K?=
 =?us-ascii?Q?ayuzZBORIS918adysDiajM5uKIELRDbhgWMByVhfz3G5GpThr4KVJDc0mtGE?=
 =?us-ascii?Q?Oe5mMpiu9MrPbtsXKl8Nn6CuNmU8BeDQ+z5hzTYbMBpJftyHJJ23/6SfTH15?=
 =?us-ascii?Q?DIyMnrir/9r3OZp3sfXAMlnfCxnsTTbLOqR+ge8a9Us9ObOtAl+rh345DRVL?=
 =?us-ascii?Q?S2p95eeEssMIYrCtIouDdXl+ZS5rKdI+MTPHhbKc7HVO4+VCdqN1L96Fk8lW?=
 =?us-ascii?Q?vzz9qaIYzpoyE/Eo419ycjI9uSioQG9o1T0RcJL2eOjyho+nVYHqgkvQk3dU?=
 =?us-ascii?Q?m1kRsL+KP62Ld5y8exIMBlTToBviO6d7hhKYJTnNXqq2bM6eKXWKX7bERleD?=
 =?us-ascii?Q?i4IZWmc7bhdhQ9n37+GI8zpSNPZHKPmxZFKJRYbu/8eHbpPW7uQAOReP5miS?=
 =?us-ascii?Q?FTwe7QppDCUQvTx1PByWozgJ+X+2qhXjDAoaLg8NEVY4qCYjLB/mNYgd6vr8?=
 =?us-ascii?Q?s8+Wcpcxa+OWFh1IV5BJPO7NQHxQScq9CeW0hKDvfdUrxOg/QBi3EmCecfYQ?=
 =?us-ascii?Q?etSpfPcNSTsrh64b3mYeydwDU1k1UHvn4S2Wu70PCG7quBjgvohPvZAjRYix?=
 =?us-ascii?Q?96T74EuiFbm9iXchDf3eJct+EzhC9JZ0RUxbafYfW3r1drGOMdGgkPcsEpPT?=
 =?us-ascii?Q?2F0AHgDLfvICPfJerDZpBLU+kmGIK9vjtLGBM8B+jfEGRNsM7wI1nk/rEQ8a?=
 =?us-ascii?Q?0tEmWbHkO6HuY2XpdJbuYfaQArD3/xu0XIZ3C0ubGR3oQNAKFWJVGidZm90+?=
 =?us-ascii?Q?dVyh4tsID/7sS9+dRT0djCbCqLAuMiogEkbCcUO9XUuQeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qobh2u4tGTkyr9iETtnsUD2llXgvH6z/LiXINDUYu2dlFluk//wfK0kv3AIV?=
 =?us-ascii?Q?Gn9G4eWyyz05KEM4kCxX3woauWbHLzI36htYslHeRY+CRyGclrzZPYUqYo6u?=
 =?us-ascii?Q?308NNa7jZi5v2A+579LaSd5eRoqTDCbyCUgyd8CmI9zLMXR+yumkMelvSS52?=
 =?us-ascii?Q?FRc1KmixMGbrEtG6XGMQC+fgYhtunDwH9Fjgdx3bz0KXml3/DWErjutYduk6?=
 =?us-ascii?Q?YaaiOCjcH2X/QEj5wiiu639+F0Lm73DT1aHikCMbKWCP900atDBMYTV9tKII?=
 =?us-ascii?Q?x7as9V6koY9facu6IVUYGGZSe098EOeusmoaiJ7XwMQAg0HLljAV7dAfSo73?=
 =?us-ascii?Q?EFaK4WkroQuYIUde/ytqax5bLz8/urmAWSh/jJ1pjJyTTKzikDw+9XNd4u3r?=
 =?us-ascii?Q?4cnZhfONYYJBDs21Pd1uUi3lNXAYpcoXLgv6wH19YCdmodAXvb2xye4OOJaF?=
 =?us-ascii?Q?Rb8YtjvgZcebq1MroEqrvpNPKh7smBGjK+6e9B/yzNjlZD5cONYLzPHIRbxv?=
 =?us-ascii?Q?Q7DdcGZXicD91F7bsk21oOmwgIXFWNoDLY5iXepVP6brEI/DCmHxdSKri5bm?=
 =?us-ascii?Q?VNIEvR3HacZ4Vu7dGf/DZ1az9NeYXSHGOGrmkxzkGeNoF2Kkp9PTY+TohW1I?=
 =?us-ascii?Q?0nG9mKwEUpM3GGqiwXykjuFjPt9e4qf847VEcqd9lf/4XaSpHGKVQV7XTJ15?=
 =?us-ascii?Q?Q9+LOkDgkVtpXY6VAalwK8oU76PJ4K44EBOkc0zZ4whXQs4LZ4s4heYsaVAu?=
 =?us-ascii?Q?QzfwewpVO6VQLRgumrqoOtzLYAYY0yP84TkrGgFyJhohIwuH3Z6NzM8WBJb+?=
 =?us-ascii?Q?XhzIfX1OEKVk9MOhW8dxOAtMYxtefN1DoqZsv8BdThA+Xy6CMjPt/BSppmjH?=
 =?us-ascii?Q?qFeKhoCmswSCxWACvPrWuUnHKYSMMuyxau0t5UhtBTLxT0jBqpgypJ8W028h?=
 =?us-ascii?Q?Sp25aCLQzTvXaeh01z+GCuXrQzAX9XL+OVYMpBQIn7kcSUYltXVXuQQq+KGV?=
 =?us-ascii?Q?llMMcXJp4fqKkPc/gNRZpNtAl72mRYE5MMq2y1V8upgFujQuT+tRrZEaJkIn?=
 =?us-ascii?Q?8oP88+pltMwV9qMdfBshjBl1mQrVTj2ZUYGYM1BN+kMP3vNCm7XT38GZjl9T?=
 =?us-ascii?Q?I0Ynt/j36bW0xGCC/ccMsLmO+Vu3d5MR7c2Gk2nQtgkww8S3ljWsLRnPyYvW?=
 =?us-ascii?Q?2sBviJ1hyldJVAGctjR10DL//Gc8JlXrjP/NNcA466lGo4w0PADWrHlk6wpY?=
 =?us-ascii?Q?B/XD4BLctGLHiYoW/LOo6g5a6x9fvJokEtdXMJp1FUJyIq7xzoE0AbfKpy2r?=
 =?us-ascii?Q?0S7CG77fUPbxQtEVKUSlVgo97H4ch2DlJO2/ivRnL/rnn9iS/ZYRRDjIIl6q?=
 =?us-ascii?Q?+GvCIlpE102m/xhmXUNwOLh7MSxNl68M2WpggnYEq7tbbjePvZzz7lVeT+2G?=
 =?us-ascii?Q?Zdc+U6Lam9jYgXsHy9qJMQnecsE0A2FI4AjV1bQDGgCk9GiMMqRBNF242iVG?=
 =?us-ascii?Q?D1skVmRpN7WELdPcXHC0bD+Vxczq1HHNrSzB2iNhPDh7fzlSNYLazHLCRxe1?=
 =?us-ascii?Q?4ycv05eLdK8/qUJk1jTVoklKGl/qF7HUl8rSpn7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cb772a-8d46-480e-5af6-08dcd14f27e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:08.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO/UtzO3M9SgVZdkYJBej9eFJooqbZV8U6tFNLamjzPW6rAMXhDCSNufl4gCixR+lykbb6TqLLmW9TcXabCd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

A FS DAX page is considered idle when its refcount drops to one. This
is currently open-coded in all file systems supporting FS DAX. Move
the idle detection to a common function to make future changes easier.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/inode.c     | 5 +----
 fs/fuse/dax.c       | 4 +---
 fs/xfs/xfs_inode.c  | 4 +---
 include/linux/dax.h | 8 ++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0..367832a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3923,10 +3923,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d..da50595 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 7dc6f32..7e27ba1 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3071,9 +3071,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e332..773dfc4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -213,6 +213,14 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+static inline int dax_wait_page_idle(struct page *page,
+				void (cb)(struct inode *),
+				struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
-- 
git-series 0.9.1

