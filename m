Return-Path: <linux-fsdevel+bounces-28979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F78972817
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC31285CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AE190485;
	Tue, 10 Sep 2024 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFFG+r3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1298190046;
	Tue, 10 Sep 2024 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941735; cv=fail; b=LrSnx5lwW2DasKPfs7gnqAuupdynByvyRu5fxJTWTgQe7g1iGbRzdR1vzjDUrrOv8v9NqsyPXIZWEt1W3ukOp/pBNzqEbZKcQehylxT0qPClvTRdDb7FTNtUimcBCqscOpYcIdH62h7G+2gxtrfZCrxysWDweX59ri7PhMukdcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941735; c=relaxed/simple;
	bh=p0r7xPVvMVqZHyjPXqe3z5FreSJZ/CBWsj9olNpyk1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcxKhj2RFZva1mrzXZurBvguum7OFFhyf/28O0YjxP7BvUzk6tRmxdffLU44XoM1QgUv74ex6GdLH7YRSnqoBzTwjX9Kg78lb1Q8NlLJHUJUMRDjWjQWQNgBpFEXIjfgAKhmGSuJLhXrtSW/81I9KWC+ZguUbJHcRAthcgI39Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RFFG+r3Q; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9TGGWrJRRAxIUWc0H03/Qy89CiicDsvu8TH5ylhM2nAsQhdSq0shaRdGEa1RbNTHDtCOUT6Ui3SRDYkLRX7chT4PD1xWecND9WtA7aH2DMJbHjO15MR2m/3zAFtGEQ8fF1ieP0uC2Cg+MdwYfVq/7CUUY0jNYkxddp4SXrOPJ7y2eZIB0uUzC93PYiImgVUTS/0l7UF3FqdqHug0YRLcgzmarsmQJ6ohFby9xw/BBpi8BLxk4igIruT67yLnqheESxnEnrld+Lfk97QzMzPDPj0asrlUb0xP6fhXv+I266FuUEDXe84t8za+gMSthovYeWsduNrmPRse6RBxNMtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItcM8EpGZKlhlFXvZ10jl4KAPka0zJ1t+4ANNPAc2z8=;
 b=haOQQGR3DNshxoUVfQ+PWw1jsQl3eFhYCg1rl1RFqTcXkRaf2fi7WxoadTSBE/uGnMyG5QwUIjrGMs77dkjWMheXfntIae7ccgWOJRs3K983tc4K8GroDwHBJRC8CBpKDKgf+9XdUYjVDdDiOG6992bD9QamMGZC03ITI7JNMcAolOyf9roqLBWAD827xp4JlDxig6p8UQqsqVB9W7PuXEMn2uLG99juV2Q/9NWW8GLZqBPGdwEX/2SPQ+34KR5reZhNNq7GYBdpBEuXat9oqZXlAyadQrY6XfxoXhWcVQKz/JsBrLj2x1hU/X26V5bMLmB7/aDaoqtCJdrYdekgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItcM8EpGZKlhlFXvZ10jl4KAPka0zJ1t+4ANNPAc2z8=;
 b=RFFG+r3QyVbxX0P0Acghf98y1J6eymXn6eiwPD7EhtP+8Oo1/4nZHL3lMD2K5HnoNUKS5Wnhsizbj/sPW1kfFLYOfQktCozwQQRDiXrObbgQdmkcGw9hQXFvEXjlgpmHbE08CSZqiUndVzoicehQD+EjByEOXZUZHgB/4RqyPW5D2dvBD23VltzD0HY4LjmAaeDA1auF+KLZEBW8LBj/dynuYjZRdeWpqChAqPeZI7du757SXM7NHGUJnvp7FDJG/XOxlwiZ/ecveY1fr5mbJomVOq/4S1qJZykTVxK8AVCkfUaCH0B+8+frA0L1Xz6dzOQu0kTiq2ImO3BpK7FZYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:15:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:30 +0000
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
Subject: [PATCH 07/12] huge_memory: Allow mappings of PMD sized pages
Date: Tue, 10 Sep 2024 14:14:32 +1000
Message-ID: <b63e8b07ceed8cf7b9cd07332132d6713853c777.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0046.ausprd01.prod.outlook.com (2603:10c6:1:1::34)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: b139175d-3b9e-4e2c-ea1c-08dcd14f3503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qSRf7qDFt8xvMAXNJwCg0p+jjeHoeQN8+Js4UWbPFYDXKXNrSvDaWQXKf8pO?=
 =?us-ascii?Q?vAGzAFFnJytfOReYi2v+pBJkT3dM+mnSeWe224nTftm0RjFa2MuFPNEiVzLV?=
 =?us-ascii?Q?lqkEKbBcmr0cbGnR+hEjT2ZaJdQ67ZFi2l/F9wiKPd1apFHc50r8/2LZuvZp?=
 =?us-ascii?Q?RxbLMq67a3bhqAdYaMXF4zef1izCU5Q4/++ObUH/vZ/+WVJhHtcbsYSuUDAc?=
 =?us-ascii?Q?H2W91IUIp58pDmZh0AuUBVNlYs/0Ijizp0eu8BLXBHgnivBwHcEfpjDmC6G0?=
 =?us-ascii?Q?I47vUpxgr+kSCugxmWdiGp9PYEdgkvAQWp6hJuKm5GAwRrqBJpLQGhXwb9Uy?=
 =?us-ascii?Q?AnGjXWEzALGhfm5cdIod7JKeXTqsOViV4Nxnw5h0hYsslEGbzkJmkmpEpA7p?=
 =?us-ascii?Q?lm4WESNCmuSti2vda9As+B4v+lYWfEgg9qieb7l7z5ji47z63XsRLy3lSegO?=
 =?us-ascii?Q?ZLpkavNiBJRg7GuJiAPQvqcbOv/4y8nFiatRRBDtt4IAk6l3JVCr7HEEIXay?=
 =?us-ascii?Q?DiqaevCOUKYywfmTFddWujjK7W7uUfOCDSQeUO26rQafaPpL6bPOK2LAKLWP?=
 =?us-ascii?Q?eWK5PIazAvm2oQ8pNJi/mQOtojHDCbdL+32rp6SC4GBHUAkHzsDAfl15VIQA?=
 =?us-ascii?Q?z2aySUc7BlAmwh6V8d35nRPwNV2ZR/sNRMOl18jSZU3XjDg7xb/7j2pjMEYS?=
 =?us-ascii?Q?w/3o7vfg3eEv5ojb8CE4DbZewpUj8KW/q5ZByHraiIh2wb7eagTCXAF7aMIC?=
 =?us-ascii?Q?/iBXv0C7ARrs4g0BZYHT+YU8SH/mVgw1ka0FzPJTo4PbrKWQT0cGA3c9mAxz?=
 =?us-ascii?Q?ynyMrv41HwPOV3zS76vY5VuCKl57BWNppjN7y/Z9QGpQ5vH5eHxWPhpkiXUy?=
 =?us-ascii?Q?i2MkqpUmMGxiMf5KSEutv2qu088u6RRLMZW10a9qiYW7xx0Yv32yoAsBLoFe?=
 =?us-ascii?Q?my7GO5ob54B8QmK2Ahi9+/3guF3202Z/mZ51ZA4DAkoKr39jS4BKXo9mCWKs?=
 =?us-ascii?Q?4zMxK2yFifQUK9hFJrYEmBLN9/9HU7DnFMm9sYmExGa7QOWToYy5WRI5lEhf?=
 =?us-ascii?Q?vowjaHlvFM3NvF4RFa0D46MoJFThud0x1qDgKE8OZCLXWqWjQql1sXzgD2mI?=
 =?us-ascii?Q?30AZZUyNknn7qhN2wTM33sCrtXeBecfRg+fsV+nxh1t3Iw/IuiV90LykxnCF?=
 =?us-ascii?Q?TfXJwnaVcClx4b6DQvygG7HV6Vc9Vj+y+zA2vShjtf7B4JO3Z38clIVs79BY?=
 =?us-ascii?Q?/dT0l4kxg5jjIiEvPn62+PDjPm/i5JtMMfNqmZ8QBRZbGYEZO0KaNnEaYFAK?=
 =?us-ascii?Q?Gfpff+/2NSiTh6+VxNAYap5hBAjpUH24wMSuqVOG+5M3xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFRNX1Sl7EXocfye4Hj2Apxs/vv4ZJvWgo/yDRCnT7968OusMCDwmNborBC+?=
 =?us-ascii?Q?BuO+69sM6rMkx2cwMkhBeth29XOTZhdn9VVT+oPYhMnRRX1qYZcERUC3AkLd?=
 =?us-ascii?Q?vFgXzOI7AXTsHuCPV56B39SEVwqk4ALecNiJdoSFv+tECTAOOwCDEWT57mom?=
 =?us-ascii?Q?tFGhtWxxBPmlBwY+F5cjmz2IBbCWSPnsSaa5iB1IygY4JCaGmeOYrA8p1JSC?=
 =?us-ascii?Q?f6LWMjZkn1vRCObvOOTZ1eXDy+ZtxSol1hFOBzXK2z7zTpVNj7HoXq9XBr7v?=
 =?us-ascii?Q?DmhPCp5xqJW+IZdVwpeNmbbFsjq7nodhxuIMY9/E5SmhR9fejB+wEJIgFOrh?=
 =?us-ascii?Q?O2yk7/EAme9NZxbbPDESxmyms+6ABHOBi+w/lV5yrDQwZqiTn1obTrykHP7y?=
 =?us-ascii?Q?BXZGpn86Lmsm7ltM87mdUpYJ4dGPPS9V4zvCMP0YPKIvR6ZDhyQVu5sOyKoa?=
 =?us-ascii?Q?ujxNcQGvw1YhDWnO5Xmkn08MNMvtKaS20cIeWfODvCjR0RAdgOlGxkZXSdop?=
 =?us-ascii?Q?yNwWG8IKJBq7+xx4GAibq1Rl/vGJAhX5HYFG5eqaAL3y9LY6hm5YiDexW7cL?=
 =?us-ascii?Q?cyaHZxM5uMqxuxEqAnlpsyxzPCn+YE3DWi+iL29KgeQX26+yaN0Dw/PYjbs7?=
 =?us-ascii?Q?ihqcLl430pvURMIuVpNB9ZVg1jzh9gCX/SnMyIbJY8GldXWKboWBDCgg+8vQ?=
 =?us-ascii?Q?8j8pIzVRBj86Xye3H7D6yMJ10xLjY+gyACc42rm0l70GSZbKnvcAfXHJqVgZ?=
 =?us-ascii?Q?MhQRFHdylrE0LiNpRvimVO/07Y86z3jCtNr1au+LjD4NtTYq+viOS0bWScvg?=
 =?us-ascii?Q?XvaU8URfUW3i26aZSeIwQCLo8thqgcUI1FuogLGnxEFmrSiDcvGhWUk00/GD?=
 =?us-ascii?Q?vr+kMxN6qMGLnA/wcJhPe22+TY1kq0zsHPAtgWCR3iKOJ3SA+BUIcbHyt/Dm?=
 =?us-ascii?Q?z2UjI90s8nmwOUpTHtqDp4Sxk+6tWOCabS0ersx9MGRDVfd+9OuZ68vmH5eW?=
 =?us-ascii?Q?5tXSQQ1pKbMISSsmrtZsmbzDBRtz5EkuMAMOJXSuRdq0I/zqxZRrjM5FZ0tQ?=
 =?us-ascii?Q?AgQ0w1nItuVm3kvTvqmBOLThax5qXQI1MePTl25TArSR4hcvTutOc6HyU7mC?=
 =?us-ascii?Q?pLKVbJCV5P17eyBN6scjtMZfkmupsWxxt4qKA/wd7KuKIi/sjBSZeo43dJrz?=
 =?us-ascii?Q?MeTkLbxltbcJGt8sPKhCqM8pEXsRfjW1ljwvJu7suS3dAdCnrBpzbKQjwP01?=
 =?us-ascii?Q?T4fuBV/vVpNZoRHlTuodbwGkLclpROT5P2UYubowf2R13JMIUxi/LdgQ4pdG?=
 =?us-ascii?Q?UFZpekwZeF2qfiB8IXwOAxyc54DxT+tYwPyCbg+s1poJKGou84jNpJb2f3lp?=
 =?us-ascii?Q?mOEn1lftNnpg4uzmlICiTS3RSZfSPPQr2LhMJzYE1TCQ8QPHBhLWIECm6Sc7?=
 =?us-ascii?Q?85prsgnpjKcvXP1LwcJHvQmm3/VZoSteCY5Md8ustIVolIYefGmOS1s1TvLi?=
 =?us-ascii?Q?ubZ1tDqFD6mQ6oOx/VNEnwjebGYzUO5dV1k87eGnGv6oPvZQYqkY3vKTyOuY?=
 =?us-ascii?Q?8hRAe66fwiI/WFht8B2LsSBg5YO2edNyHsEawsTs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b139175d-3b9e-4e2c-ea1c-08dcd14f3503
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:30.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHC8+DlOYjhRod5vWNyyQZeQ67SvJaANrbVN7lz0epJCBkXqP+OcCtofVooBYis+/gswvAOOkb0QI6v/j0Y6Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce dax_insert_pfn_pmd. This will map the entire PMD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
simply inserts a special devmap PMD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 57 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index d3a1872..eaf3f78 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -40,6 +40,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 
 enum transparent_hugepage_flag {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e8985a4..790041e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1237,14 +1237,12 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
-	spinlock_t *ptl;
 
-	ptl = pmd_lock(mm, pmd);
 	if (!pmd_none(*pmd)) {
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				goto out_unlock;
+				return;
 			}
 			entry = pmd_mkyoung(*pmd);
 			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -1252,7 +1250,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 				update_mmu_cache_pmd(vma, addr, pmd);
 		}
 
-		goto out_unlock;
+		return;
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
@@ -1271,11 +1269,6 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
-
-out_unlock:
-	spin_unlock(ptl);
-	if (pgtable)
-		pte_free(mm, pgtable);
 }
 
 /**
@@ -1294,6 +1287,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
 	pgtable_t pgtable = NULL;
+	spinlock_t *ptl;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1316,12 +1310,55 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	}
 
 	track_pfn_insert(vma, &pgprot, pfn);
-
+	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(vma->vm_mm, pgtable);
+
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PMD_MASK;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	pgtable_t pgtable = NULL;
+	struct folio *folio;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	track_pfn_insert(vma, &vma->vm_page_prot, pfn);
+
+	ptl = pmd_lock(mm, vmf->pmd);
+	if (pmd_none(*vmf->pmd)) {
+		page = pfn_t_to_page(pfn);
+		folio = page_folio(page);
+		folio_get(folio);
+		folio_add_file_rmap_pmd(folio, page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
+	}
+	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, vma->vm_page_prot,
+		write, pgtable);
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(dax_insert_pfn_pmd);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-- 
git-series 0.9.1

