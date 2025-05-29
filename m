Return-Path: <linux-fsdevel+bounces-50030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE7AC78D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E490A17A6B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28B2586C8;
	Thu, 29 May 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nfiVItnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C22571DC;
	Thu, 29 May 2025 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500354; cv=fail; b=pnHgI3HYkxG2Mld+Q4stbvy6kdIgzk8ABabcJa2DTD2ZR3CLkzcToaIraiOdesNf8kSK49hIco2Ubx6VdDbW3Pqa2TDvXzIEoGcgMKrMn5Epappogji3Uno9EX2TYe2hcp1ZKzt7DJJ52slTFOhXDwjSBQ+SjtcHRtaWiQY7ZTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500354; c=relaxed/simple;
	bh=M/D8SrlKseVw+7J7aFTMNhaaT8gjpuC83Tj/1ZQ/6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTjnTYFX+utLG4awoQrDQPD953HH+8kG0R5gcPhgfMkHOf40dejaFzkwyKhfEWdZ/F8X/quhCaN4mwqtlVcP3PHjkOb5oYGq444apbfGzD1lfSZrXpcm4vTMBbnlBf9aN8NGgYyzNbhuhWIq6KwZ0QlxwcVr9CEwNB61ILb6wrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nfiVItnT; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5t1ZKGMIOl21d4n+T8aPizadUPhzBBIX+bf+0heXHLaumpPv/5gy2OU/c1vssXQ55JpSEoR2n5706OUB+beCQ/6Q3/XlobBBWDuz6tYDQSsQZaG2mIOl/aUtnBB17ophK4lDyS9vwkssMBeEWesbdZv+EPbZzTUNIPCLC1iJgkQLPoZd93omHGFY2IqwTIv151R8Ee94VOU+YuyWmdQRdtMoHRTvQui+MlOsYZD/J+iALiBMfX3ZFl/o3NWdCgXJHeRhAI+hk2o65v6o740BgE/pes60nmqk5DxwtdZxbitBMx9jxCiXEwYqBqbQdv37o2Tf7pKzJdzCMImZtIDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg2mOGtbKtaQcGxCFg2WlQwkGUGQVDZod3aANGNbzX4=;
 b=fyDKa6YuUn4QZsut/jkpAePeQMrxNLdwcXiIiFVS8VI8W0w1qKQPthr/frVCT5ozO/MW5AsBI0a4L99DY8WYR9i1+IC5IiGc0lIikZwWNGx1dfrV/d0HktkrHDiNw29u0DVNOraUbgehwxS9RW3XwiRuff5y5Z2sRL2JhvuN3npKarkz2o+k4KEkQASEt+kusySpOb7zQUtnHQYIlBaCwKS+mnNHMWWnpsiaY1Hx+aXqT/K4nZl0gs8Uk7HWYQ/cOA3sgT5S1RzH4fEx+2YRedCjIf5AsQAGzsCfd36Pl+SBJYAqlgJKwkGKASxKSB7/R5dHB2oQ54dqqH8xt9+6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg2mOGtbKtaQcGxCFg2WlQwkGUGQVDZod3aANGNbzX4=;
 b=nfiVItnTRsudjLlU88YMvh0WMDOA7UQb+BnynBHNDOv/ypaGjcy7hqzMQgnn6G9QRK1jahG1dcQ4o8T9Eip2rKtdtVNiaVqCJaeWAUJucHFNnyVHm+yn7ky7u6NLRn6lsCX0U5BUZJymraJjv1SMvvKTFQgxTPD+VsMc13VmvhnpnVr1HS3LmT3A3iYpHNdxDkSoYrpJWmE2aCAB9AlSXEDTiZ9K1sKBEImOp2fsVEXTBmMGOnwF+bfyNYQDsR4W9jbxtnG778w/QPLF7sgCiQomJTIQmZ/tx462SH5ke0hqikkECNCgVUtZnljlV7Sga91epnN+S/8X9X6tiSWmFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:32:30 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:32:30 +0000
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
Subject: [PATCH 02/12] mm: Convert pXd_devmap checks to vma_is_dax
Date: Thu, 29 May 2025 16:32:03 +1000
Message-ID: <224f0265027a9578534586fa1f6ed80270aa24d5.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::12) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e236d42-c823-44a8-a928-08dd9e7a968c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FCnYCUZ3Vxv7lfCjFoWXAVCemUH/FdEb2OhUXVvG8v0ufI+iNXGPoJkwAZ4y?=
 =?us-ascii?Q?0QSWHzNqvB8v/atner5WB6/97UOX+j3472j2gJAGje5yAQKFjUoox90EfNXX?=
 =?us-ascii?Q?v2JE6SCntreu8zCiO/x35CxG9vkxZtphCq/VeYSO1waskHYlGP44kBLRruID?=
 =?us-ascii?Q?zHut6DaZT5IH5n/2zsbKYDEi5oDBxUm7f4Gwa6gTw5qSnWiqEkDNWiegeMUt?=
 =?us-ascii?Q?V6Mdi9uKuP2p47yNYNXihY+P5zvkHrzMtJysTX9zVhAv6fHnLQVB5L+mm1Y/?=
 =?us-ascii?Q?46RsyQItUS3/OdFDMNUr31sTN+zJDN7lR3mtw+ykuth52gTvKLoP6uD95PER?=
 =?us-ascii?Q?aWrX0rSt05SnVsJ5jtXMMzZVpApz3yk+W8OPlHnP0Q1Ld6p3+mF4u0f9QEUO?=
 =?us-ascii?Q?m2skUJ6bu0ZDT0WDF4Hy4NAqUbcM41UAeJUe6xWCHUh7buQRebjHjVr2EkdS?=
 =?us-ascii?Q?g1ECf0NBC52NKkicOSuO8QzUBDqUCv87xH8VNrEr5l1yCdWjMnl7yNh+UxQc?=
 =?us-ascii?Q?cHCi6qcnMXnFw8/Vhm7B0LIBwbrH/zYbh1IQ8jmaFSKeqI01oQD7zDKYE8m/?=
 =?us-ascii?Q?GE9kDcAm4iub/vI0p8B23NwqwTTv8kfrCh3NJMVLfsTKqhLodQajv9fLPcU7?=
 =?us-ascii?Q?dd/JW1EIISYgcaeRIAI6ZvkClSYnq3PQtALo/rgPBEesmbsRGZ7pkTXxUGJE?=
 =?us-ascii?Q?pYSRSkKbqVm1HXpSowO41TncCIP5NZhE4uRwQuRUEVDyr/TTf7fBZmSi+D7E?=
 =?us-ascii?Q?35KYitJp0IjQYr0wbeBLRXodze9bcIpNOfI19XhZQ9n9981EGl1iinMd3R7h?=
 =?us-ascii?Q?1H5h7eNsYTt4xBIzuJQktkH5s5kdFEaEtYs8XXYVEoGqiGBKG00uJ6HSPDq3?=
 =?us-ascii?Q?QpySnU658NDRA5rZfZDkA986WpA5aJvIXHYBLklmsfOHw36/H6coDZYDeRb+?=
 =?us-ascii?Q?uKgSkTMUzrrU0QwAGwXpgmVG5So1YdGYOPTv2dBhFf6kALBOGFAbGgJngPfJ?=
 =?us-ascii?Q?00HlwQtWDO+pYdkCtP7mDk9KRoy2h4duDWlvg4QPmImChkp3zzxH8PUzDHF5?=
 =?us-ascii?Q?hEZnhybr57oOM23uiZDTQdFu/+1EdF7an/S9eFNqLNMgLbKH6+ty/J2nnrSq?=
 =?us-ascii?Q?F7+US3Ec77erQBEG2ZPPOy0oIPmR4ens80SjXbRIxMuh+xU8BU0a4F8s1Ret?=
 =?us-ascii?Q?6wsZsK5vKmXtibFizxYOScDJAS3FAkRXS2mAROe4Ie5LTktK6oYIecENRlfd?=
 =?us-ascii?Q?d4hxzDIt7ujLMhkIZHiEW56JB2Tpx9qHRc2W/SNFRTueYJgtOuBYXfK/EI0r?=
 =?us-ascii?Q?Ob6VtkzKhsoJZSNAOVraFASPUldRWgwISpNTFKlb+bMhSZcs1nzRT9UVhdVK?=
 =?us-ascii?Q?ViHv9dGXSCqtKwFx5R5n5uCzpYyMLkO/Li7THNZPia6U4Sl58XtcgthslL/R?=
 =?us-ascii?Q?nFL6rhyU6+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0kq9+AJ0cbRz0HjE3Q1yM+GE2iLqE0VRNkL8Ts2TuSN5ou+pjpmS4mr8En5Y?=
 =?us-ascii?Q?IpjabnUDfLJ9NHQOZM3SK54As7eHCE0hlqlxi4rJLsKkSC0G8LY2PXfj6yGQ?=
 =?us-ascii?Q?XKMQSQwKtyUJXJIFRJW2GmkHoPODBjVEoBkZq4Du+eyG8PwnjBKFwHYBqKbE?=
 =?us-ascii?Q?x8UKFIs1mhCf6BCy82nyQtKL0Tm/p2lRsqwOU+s3u/1eWsxvf/R5QhxG2gWF?=
 =?us-ascii?Q?PYGY99ZCM2WBr+iOjNK2KV72DMoZzoaucXPPRBqyiw+Je54XXQaljGjAcZIw?=
 =?us-ascii?Q?gLfn9ksAkVrmzJvUERnbW7Zi4qIrXdtGtFThg9zbMyVUg+CLa+3DW8EkoVm2?=
 =?us-ascii?Q?nnXQGxAuuUXAEB8xVnBRii0ZzsCXKwkRGmL0wxK/aRxUjUNdjLEyDji6zftv?=
 =?us-ascii?Q?n7jX+jnAWuasR7nP9ZlMpTfUXLUvtauGVsdliEU4tslpsM2sMUXCDmOqCMUe?=
 =?us-ascii?Q?b6fVgVJAo3WDTBwYV5Z5aAepzYkAdVvgfiFhB9nJMI9rYCZ13nbwThCBdjLM?=
 =?us-ascii?Q?+y4GPDM//etoYNQXkdO8MSzZY2dHLkJRCqYlb/awhzIO4IiEJXY8wBH8vk63?=
 =?us-ascii?Q?b6kDznPAJv9ZsRDKLVyCXZvEKlLcLncUtapuIlCssISdb4nTRdW7z9qE6qcx?=
 =?us-ascii?Q?WJiLVjPBMP3Jp2Ne1ySxhDORYnbrhIftVRIB3MNaEPuG+3N+aITOcIfnKqcl?=
 =?us-ascii?Q?2fHntl7kAqZz+OUCvKGBvDk4xiUdzGNJ9YfAt7eHOOTdNVS0hoA52W4oZGCd?=
 =?us-ascii?Q?kFVxtMGjBaV0YUMPls3I6DXSkZXhRdJwa0DJzS+0r1yJVsMEOH/61mVFsKPc?=
 =?us-ascii?Q?1N4sIhgcZ2Yz/CmF2mJT3mlhqyT6ypSbBPAJCfI+VzAPHdUxlwRctds4k7yg?=
 =?us-ascii?Q?u9jrjTd9y8PW1rOVJJjKA2xGTIW7AECZtB39jtBvS2KRM9YjHzquHrv6KFaM?=
 =?us-ascii?Q?w0dervmrPGhM9/BkBRjB8FNSecCfcjHZPz2Gp6xSh49YG+8LEDzQPW3anEF8?=
 =?us-ascii?Q?zo11Sej5M0QPYSSrtQ0KjuJxy9vthdqgXaYLwC8/p2YEvkmUEJdZAOjnXA2W?=
 =?us-ascii?Q?H30ve09gO/R/wTyQng6a+uuBap1Z3z7kgb3AYcH75U7X0CNiQZbfR9kXS/cr?=
 =?us-ascii?Q?AWlSfkQVPSF0typKHWIpT/t+LkMfsw+FQ1avEde1sQ/Je7JCwejdkaXO2zeY?=
 =?us-ascii?Q?4zGfgMuYoePr1QzSXHlgUwfT1rzOQOs7W8zstDx/eavKJq1QQoKSJR0s4kmS?=
 =?us-ascii?Q?7Xt6vZlsemtZqfRv18uw/TLBF9RDCrPaFJfsN/RDbnNqNPhGUo36m6kON1y7?=
 =?us-ascii?Q?J3paj+Kac8y2tEpwraVLRd4EyDpJnhkI6R2amtzTP7UIF16zOIDKEiKl5lbV?=
 =?us-ascii?Q?GDJHaf00157EcIg31oC2kUarJuPJz7Am+ShY9wkNGTvYcgZjnbqO6mV/Jl+W?=
 =?us-ascii?Q?sIWS7vrKDbTQDCLqaB/P5YSoU4TDKZYGaYwL0YWej6HjcjJJTPSzboAOFXHd?=
 =?us-ascii?Q?OTN/kb0Aj8lZyxbgaq4bTmu8nfVmhxFmW1SdQ/zfn/KyXRBDu9NARLRRPB1P?=
 =?us-ascii?Q?cOaJVOZxeKGBB6+dRhfDAK4c7bmndzyZ3Ob1YuuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e236d42-c823-44a8-a928-08dd9e7a968c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:32:30.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2HRVEw3fl4kvQngGUfpuj4bZm3vzRGABvPJZHtZXzJSoOa6laXgxNj9etBnP2WXCv1YsxMJnE4XcSawHxaSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

Currently dax is the only user of pmd and pud mapped ZONE_DEVICE
pages. Therefore page walkers that want to exclude DAX pages can check
pmd_devmap or pud_devmap. However soon dax will no longer set PFN_DEV,
meaning dax pages are mapped as normal pages.

Ensure page walkers that currently use pXd_devmap to skip DAX pages
continue to do so by adding explicit checks of the VMA instead.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/userfaultfd.c | 2 +-
 mm/hmm.c         | 2 +-
 mm/userfaultfd.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22f4bf9..de671d3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd) || vma_is_dax(vmf->vma))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index 082f7b7..db12c0a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -429,7 +429,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud) && vma_is_dax(walk->vma)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e0db855..133f750 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1791,7 +1791,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			if (pmd_devmap(*src_pmd)) {
+			if (vma_is_dax(src_vma)) {
 				spin_unlock(ptl);
 				err = -ENOENT;
 				break;
-- 
git-series 0.9.1

