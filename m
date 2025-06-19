Return-Path: <linux-fsdevel+bounces-52181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D34AE0100
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26A93B13A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE7284B3F;
	Thu, 19 Jun 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBApE0LS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4326E6E9;
	Thu, 19 Jun 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323553; cv=fail; b=AbmPEUKE4KNYSvpYw2FXu6TgWF/bdr/yBxDQ8fa9y6mYMrBPGZ8diMLpH0/Yr1QKi+BVqTtthvnX/jSByZyZvxr0VpfnIkL0QTPCt39z5ZgJJNcbX5pR0HQgfKuh5u2sPwNqFRA/dEU4iWQbuHP8Xse5N3B3m+gTl9jAOrY/w/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323553; c=relaxed/simple;
	bh=stOnnbWeGcmYzCpKgIK7MX0z98BlTdCSuyX9y8YXHCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URmpLotidQbtEmFK6h5Rb+op28s2axYqOSc4GdTPYQEAU9mtym+0GbWW8HqV9M3auVSx0MvZYOYL1z5pBR4TeA9JejOcz6cTooAH3N6EcmRphajYBL/lIkcwM25270OJinNlB6tHVVqiZVKPO8T+du5IZU1jniPImWf+Du1tUDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBApE0LS; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnjafBvsdZm+x92IfRcFLvBOWvihaXNPUp4rjWXLAst27LTW54taT3TmqMbB7UfG7HAn90OVOMDOECaW0DOYpAHPofKDdW3e1ApkqfrfBsynvD2EHBdx2nEIXnHUju7eCTv2JUnlr9d2jbP6Oo+Un5ujs0lcWLW8XFSRXcBhC5atLIhO0+EeiS1oaNpeZP7vReC2ncB9RajIouGvWCxlnlrk+3o1Nry0IAe9HmqJ9eoVhR9UVrPkTgr49oI76OxUhuP9tpd3RxKvjOF3de/c5KdEWkZqNvkzbXkI32Y583Bv+d+AsCBwfs9TbEqFttITq74OSfs1BucK9f963yMnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJx+4TsqaA2QCzMC2S0swX7BjUUd6UbLBhcV9JcAIMo=;
 b=eaRDIKlYMHbxHuVS22LKhKFqq1o3LcJPs4bgGqqPcG2zWFTN6zPW5GZVF1HY2qB3mF88raYYy1OoS5woAAW94y9/JB1rALsUSFVvNdTBY9QjkH0h5tueQ2Nu7M8TID7tAbh8eZKr7aaEN2sYfilbYhr+rQ1wMp0oGD+yd/tkLWKvmnEXr8FEZXklhH3LUZ9J4ar0Cnik8V4lrnNciaoOX9PC9is0mJbemH3HtpDLG6t2zwQjUwo6rQq2Ldx0Xe5nOGxCEcWb82cmoVHtlUT/zfJvL0vyD1O+o1FEPi5b1UfQebFyfuXRV8cZ3Qa1gmL9Ty3xupN0GV1Xi02IRkZg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJx+4TsqaA2QCzMC2S0swX7BjUUd6UbLBhcV9JcAIMo=;
 b=LBApE0LSpIiPn43zNp2kHf4LThscIp1Zarw5sojkdm4BTJ41biL8cpKgpK3APmP8BaZo50Cv/aUfXolZBWDw8d4CaZwu60AHNACIYWxN0w1rZ8qeMWPyuBHuNE6QQBLnee1TVYvb6XhB4ySnYqYpkRkUUFuw6tDgdt32i1phh7RJ6KKH0LNA4mfv9gLW71i0rcU0fhEVm+3ZebPnAIRDehBEYheaYA5JEISJAjBydZc4x0G/eehqYdf5tX8DzafXZ/6g/muCdL66ZC62zZzhFICxPN1fYKcdrEzpQR7YxFXt57XHALNmNbMS9Zt6FQNrcyEaksYiLpMIi8nC7hjTWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:59:08 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:59:07 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
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
	John@Groves.net,
	m.szyprowski@samsung.com
Subject: [PATCH v3 10/14] fs/dax: Remove FS_DAX_LIMITED config option
Date: Thu, 19 Jun 2025 18:58:02 +1000
Message-ID: <b47bf164b4a1013d736fa1a3d501bc8b8e71311f.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a5bb11-2b95-46cd-e040-08ddaf0f8ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VRHpzGVTTpe3m5MICqyLjijgtD84gU9C85PkCsYTbPKfVrhW7llQlJERp9wP?=
 =?us-ascii?Q?dj2YtxncuBvEp7gMybEPoyHdMiX7HiIeNkyb0FXd9ZCBzBAqBWxS/cbL0Wlu?=
 =?us-ascii?Q?37PeMoAM9OIskgVlheBsYZgbFHElj6e5XiZoY7Iike6KoGiROBYcNO1+Clem?=
 =?us-ascii?Q?8xHu57W1Tjr+zNMQj0rP0O/s3Ekasg0er5sdL0lR+EP7qwmai/F7oqCjmfYP?=
 =?us-ascii?Q?9a8ru88TIKpEC9XsonzLc/bGTTrmuXV9ImEC/nnb/z5ggTozg8U50GlZwYEf?=
 =?us-ascii?Q?5MybkUbVfc3hR6qfq2Fzpx9xICggjD++8WbrRGM87Zfx/HAvAZNr6WjIMh5u?=
 =?us-ascii?Q?b/9xFms4BSjC2FWkxjB73SvqjBs6p0zCEg7JChD0CNszAHasmOAx95dhqktR?=
 =?us-ascii?Q?p4nj5qBL3BNxT0d44FgI9CY4bl2q2DrSX71lf+mtN4BY4j/rFvQBgG3onHFL?=
 =?us-ascii?Q?CQE1JyCBcbPEPnw9+RRrBHL6g2au7bPAXvoq5pqeKZSW8Dn9aY7IjRab120E?=
 =?us-ascii?Q?k7POO8rPDtKRk4eE/gmm4TvmzgoMERKSERBxWKMfodxRuHQDPiwUApUpDh44?=
 =?us-ascii?Q?Gq9ykfKWFmWEAjuGR9aytaPBNa//ozyH0I7NJqJYZSf0uApPuh3cGJheuF9D?=
 =?us-ascii?Q?/LU2SyEj6ISB17Rs/BtENPbLYDWbz5T+xP/1fm+4wwKF85DsxVsLG/j41ZoO?=
 =?us-ascii?Q?U3HRrIt7GWQQctdl5HhkYNWSjezS2KkP0Tqn7zFHO0spTRXJXQ/aR2cwhgR4?=
 =?us-ascii?Q?8CgBiMZB0BR24YUEKgneBc1Fa1QNFYGcxbyUNItC0vOHuBXBmuFK9Q9vjrJD?=
 =?us-ascii?Q?2ir2Ok2GPNOH2/LSMjWkuYzzQdpoJsdAJpSClIg/MDAnDIN3Em3nPHGmkKWC?=
 =?us-ascii?Q?FnZgcBlN828ey+QXtZR1ljdaSOJOgWIxKLPgZapcfVY4TE6Vjt+Mrz53WT4K?=
 =?us-ascii?Q?fouFq2Pn8lHoCb6URDjwgChuT37eueZdGQjiBa6D0CvnJ44KlWwA3iY7/HdT?=
 =?us-ascii?Q?9l1GUJaFkSJPH6itT1lxCdi2Bdd+gyXhGhD4HrYS4vfRw8KkRsTrltNyIZh6?=
 =?us-ascii?Q?wgpZCI047+dq2nY19/rpsx/SMYV0aoi4lVl4MK34kOLrgKhIXKGemhtcNJLu?=
 =?us-ascii?Q?M8XJr1j4fHxZq66yp2K9BCiLR3hnBEPH25Ofm7Rn1n6qSsYd6NKid9kroMdZ?=
 =?us-ascii?Q?ACpwZoPdAINwxy6cIYv+tqvsIIkJbgW8TKEjJE1ETOuKT1unsmRyyBj8pPRr?=
 =?us-ascii?Q?mKr8SMIo3gPJkzBQoO9CU+SqPsUcJQ+hYstCL80Hct8GSg68IgVqub5E0aD2?=
 =?us-ascii?Q?Rtaku4UfxInVIFVHJwsZ1vTz+VLU2HIPAb6YviXIpMp+KhxU5gawJ6JVM5ht?=
 =?us-ascii?Q?FfSapiCX33bx9RRXuDXuBWfj+oX2z/WMjB0UD7pZmrP/xTYX0jOs2S7O9vHo?=
 =?us-ascii?Q?NZY7y7j5iA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ym8svtuBwr08QD/R4oTot19tDTWPLhgPWpceft8zkNPtV4HSErs7sv/WrbaP?=
 =?us-ascii?Q?mSXINyneYzGhllL7IkaeAavp5O6A0P81NfVbXiDAK6rHtrFqCTH85X1Yk2t3?=
 =?us-ascii?Q?rXHJdCJHCYiLgotTU3yvKOKg8Elh2hCXpYTCz1C1abOxAhkN8o+qu4rNLhGb?=
 =?us-ascii?Q?nCczhV5HF3OsLNIP4wnX4i3e7Fnqj8IJnNRcd6UeLPUnFQw8HK77RNpPwj7M?=
 =?us-ascii?Q?0i3icfFPxCRS+eqi2FiQb51klunkS0JyYecGmqn73VcwcTykdFWQ9HtiOMGN?=
 =?us-ascii?Q?ZpYyTM58k9kkM1qlh3ALBgXKEwNO1VzUFvaAReDPAdr+Q45/dYirohmS5fP2?=
 =?us-ascii?Q?JoIskBvEC+YsbWJUQeYyRpr32pocBUHeLza7rA7dMK35tfcxUCIn4g3A5JBi?=
 =?us-ascii?Q?oE5J4eDFRuUMUHg33C2UMwLOzUgSBhpyzOh4VD4+JJeulB++M95qKNpGkXSx?=
 =?us-ascii?Q?+sCW1/fG2qyER7LtXDFxeJbGDc7DpElNXmi+6f5HeTaNtYmeRCTWJg/9tKCZ?=
 =?us-ascii?Q?XSYHZ6vOjsDCa3E/0mmUA5xYomEKXxxFCzgwQnX9CnjKO3yci1vRcOuVsdz2?=
 =?us-ascii?Q?QnoCWeIuKzvTx8F9shfLVj1lpGJBVK02twpFDptdo2RLynrqSIqDxGpwW4YX?=
 =?us-ascii?Q?1mcFGNytyzCpQzVYBecC0YM5R3bJGsz3EE8159I3Hcz1Tp+T8at7pVNMGfPp?=
 =?us-ascii?Q?mIobEh/QiNRZWIHZ3o7XsY61L2heglkcTPdaFfBS5dE9vXr9Y1hDviaca88T?=
 =?us-ascii?Q?TQQQTS7I1mN3CXJHELbUD8tPH2wzYvFBLFnYHfzwlMWN5kUJlaTdG0l3BoLI?=
 =?us-ascii?Q?SjjVhh0m0M33WJvWtgilgzfOEjhUbNmyUtJB6JYMjMlzvFwwOaKH3tCqnXBj?=
 =?us-ascii?Q?frnWl7vRHIopMRFvMkc6DcW73w4bMnG4FmPlkpzcNlR/R4UTvbUQsOIu1922?=
 =?us-ascii?Q?CwHH5Otx1MRMDbq7M8MT1/z+unEZjpqqcjteMHpNiruYPV1V9Qd5vhJStotr?=
 =?us-ascii?Q?wtYhgBztDg5how8+jM1nx4jAi+Vse1e/fQ2rbQLIZ7nTlBqCJFA+6bqYLt8X?=
 =?us-ascii?Q?0OuFTzn4tdieFHbkv7ZvUSTbCR45TFuMrADPLxIEZbpQf00vPme6CERs9l/7?=
 =?us-ascii?Q?03ZikkKaZp2kChe3uG8/neX2kJ4fRigbBG0LtVFCwHSbi35qv88ZySR6DJxw?=
 =?us-ascii?Q?e9uAIqL3qhoEn0fokB0EoiCNV/oZbjcmhJxRJsK/eiMbXeFD2bN00PIgNfR1?=
 =?us-ascii?Q?DUrJMYuyu4pBawQzl53zndgrkTIhSHGc2hGUzwB21U1skjuFn6E5QgOJMGok?=
 =?us-ascii?Q?9uR7iVru5ZFyMNTFjKVNZ4e6aJd2hc/FObgH6/e4t4cxhGJyOqWqcW2vn07w?=
 =?us-ascii?Q?qnMZH8mUeWS/mLFizxCR8L5loHxbinPgCuLOW5RWGMdeRVcMjPBMeiWdw/FX?=
 =?us-ascii?Q?wVACF0XARZ5t2Au2BolAdxANHWqMS8eaPl3SB49jaqwBfzyMZVMn5Xo8pL4b?=
 =?us-ascii?Q?0ZlDH+9D1ySS4zTIPrJOwx3XImadtOjLPurPetTn/0BGqkmtyNcCNXXNS2GI?=
 =?us-ascii?Q?2FBXpLnjV2aPl2MH+LBonW6fxXF1B6jN0fAE8H8M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a5bb11-2b95-46cd-e040-08ddaf0f8ca4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:59:07.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22gUJMxPxcRr+EKzIjEj5In3cWHceMvTNAZgx2Wh82mSImwqHm4fOov6UQQQeQW2gnyOrjFuI4e9LHhvH7GAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

The dcssblk driver was the last user of FS_DAX_LIMITED. That was marked
broken by 653d7825c149 ("dcssblk: mark DAX broken, remove FS_DAX_LIMITED
support") to allow removal of PFN_SPECIAL. However the FS_DAX_LIMITED
config option itself was not removed, so do that now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes since v1:

 - New for v2.
---
 fs/Kconfig    |  9 +--------
 fs/dax.c      | 12 ------------
 mm/memremap.c |  4 ----
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 44b6cdd..ccdf371 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -59,7 +59,7 @@ endif # BLOCK
 config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
-	depends on ZONE_DEVICE || FS_DAX_LIMITED
+	depends on ZONE_DEVICE
 	select FS_IOMAP
 	select DAX
 	help
@@ -95,13 +95,6 @@ config FS_DAX_PMD
 	depends on ZONE_DEVICE
 	depends on TRANSPARENT_HUGEPAGE
 
-# Selected by DAX drivers that do not expect filesystem DAX to support
-# get_user_pages() of DAX mappings. I.e. "limited" indicates no support
-# for fork() of processes with MAP_SHARED mappings or support for
-# direct-I/O to a DAX mapping.
-config FS_DAX_LIMITED
-	bool
-
 # Posix ACL utility routines
 #
 # Note: Posix ACLs can be implemented without these helpers.  Never use
diff --git a/fs/dax.c b/fs/dax.c
index 7d4ecb9..f4ffb69 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -449,9 +449,6 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
 	index = linear_page_index(vma, address & ~(size - 1));
 	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
 		if (folio->mapping)
@@ -474,9 +471,6 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 {
 	struct folio *folio = dax_to_folio(entry);
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
@@ -768,12 +762,6 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	pgoff_t end_idx;
 	XA_STATE(xas, &mapping->i_pages, start_idx);
 
-	/*
-	 * In the 'limited' case get_user_pages() for dax is disabled.
-	 */
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return NULL;
-
 	if (!dax_mapping(mapping))
 		return NULL;
 
diff --git a/mm/memremap.c b/mm/memremap.c
index c417c84..c17e0a6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -332,10 +332,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		}
 		break;
 	case MEMORY_DEVICE_FS_DAX:
-		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
-			WARN(1, "File system DAX not supported\n");
-			return ERR_PTR(-EINVAL);
-		}
 		params.pgprot = pgprot_decrypted(params.pgprot);
 		break;
 	case MEMORY_DEVICE_GENERIC:
-- 
git-series 0.9.1

