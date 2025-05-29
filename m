Return-Path: <linux-fsdevel+bounces-50029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1536AC78C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CD13A955F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2312571A2;
	Thu, 29 May 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8Inixbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC052566D7;
	Thu, 29 May 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500350; cv=fail; b=d3DuzCcsOtoM9QgVac4I0/DTTecERYGcEQEaEtislcZd7Fwr6xAfxjQKHRIcycqCFKIGGquy+a/sOQjlU3tpWMZkJVxojQi5G3+mGx9EWFd+6v1HTFwt+x1TI81qINOTcfHWBrHq+YnACJLdPh+BMiFILMfidFov0r5G4bBKyLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500350; c=relaxed/simple;
	bh=kYIQWDLuPN9OxKGkn4Gg6uQysMPXfvGdXxnNi1OnyTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmDifnpVfDUiUApdpNy/5iViz2/CpTsqERtcYo1d9YVY9dgUnUcNw3/VAV8v4epIfvfA2SPZV9JNfZguET+CbzyUtG+N1OWOP1Ny7H68etcKlPgK2F8U24bUlJuRhgiVCcCmKx6CAwhibpkRBHGizuiD7nJpHVMOb1UiVQUYc04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8Inixbs; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5oZhwZ845z1cckd5Id40k+O36WeVsLLC5hsrTQ/wN+rzqDwed5sT2qe8UHoSFsLvunng9khpSRDPPIa5ByfDP6sr2i9Apj64U5Fzftgh+rxr4TmwFrYyCLi+RfEkk2cG4o+6ADGeazg0Z+IKznDTLio1bz6KPlUoK1JrEAt11Q9Or3tx5xGVmc2OdTHrcxRHjKiB9HCN0p1aU6V1EJMDIF73U2QMINhQ0X8/LRkvzTY2zzyewuLMpP08WXuLzePT7QHFEUEjFAB/UE+U65oWxlp5ke2f4xwo+uFUEYlkXYOgkDPv4cwOGI257wFPb1I1KaFUAREtLXZtVzdcfO/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=717FxiVERW958g88YoD/zloVFt4+qCRSPZCIGMl5g8g=;
 b=bbloYaUPHNhxJYMfkqip3bqugte5CyrGXtNK6oZ7VvMCk+Y3QvW1dncsWAwg7s79YMAJ6Uy8skiro1Qrorn9YY759vXZG2Llgjb/Ev73kfAoLY0DUOXR14IM0r3AHGUGmmooHgPLVruRdWF0xV4cxLThlNJcgCtczheFNV1ZLr2ZtIvcwLW96mkFdGNp/3QS52Qc5CZYFnH+mdQKmpbHcJm1XB+oaFjXwY5LKiqv90jTamEfLnuVw87PR49fzQ4AfB2PgqNrTWLnuwVy7PjOFGomtPks/bNm/ljgKRHCviXdZvECx7GORWD/M9tz0zgBJWqM+iLm72ABCfBonbqhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=717FxiVERW958g88YoD/zloVFt4+qCRSPZCIGMl5g8g=;
 b=H8InixbsdhFtxGrt8XcGBqnN/3oF9H8ogIX6uifG048LKYafzkz0NvI9mhaPKTlheQXwVHPGvqH/q0aWtO1BpMUTjxig4QPK8B4gssK8urZ0fa0Jwn7o6j1uMkvNJMI1N54o+OQJ8IyWjHFLxw8MixuiR6gBO0z/lUMQS5lofAp5CD4XfPGpKwj4kztWT0BZDNhqGEDUjGPMj8aGg773gvLWyXKrmHBexnxfK2fv+vWl95cfVbgRP/GDpBEiR7hLAgvK7/nAI5pGjso3N0K15K3WLpMZcdH5VsUnIInzq0hC0+61LHzWFfUukOgqXS978rXp+Nsj0r6Q/BOg/cRLsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:32:26 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:32:26 +0000
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
Subject: [PATCH 01/12] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Date: Thu, 29 May 2025 16:32:02 +1000
Message-ID: <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0127.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::16) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afbaa1f-2aa5-4647-5919-08dd9e7a93db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tjf6vKsUPFkQm9g6krYzNkxVpNfdLhFj/HMOAS47g98VcVn8xzEMRnvMYPSi?=
 =?us-ascii?Q?Nw90wogHWWJ5vCeufMtP0wTlo0aSWbV6nPBov/pricPTZ//5PUeWOumjuv0C?=
 =?us-ascii?Q?QrWZ3XTN8GRjmOeotw3yMJhW0gjvo+R7FUnKoVtWIB+1HUDUT6d9t0fxBS/b?=
 =?us-ascii?Q?XbKOHYF/XOeEn8QpjjhsoGqSwGsgfbJk96hslU8oYjeGbbd4Yf0/3Ey+atc1?=
 =?us-ascii?Q?/tyHTnlCVNdfjW9vTaaK74afre/XIlRMyQj1JH0GngmWUEIr3CHQFDmAZAKF?=
 =?us-ascii?Q?/qax/CN5a1tyDl7tGzOb36b8SinbKeQlztoK+2k/IuPIVFfleL6rKnKGE1Hz?=
 =?us-ascii?Q?QM/n7HLH5HlSpiYQsxMqIRpitKWPPRYfeSCKtd38XHEZ9E7akeygCQCvFNVU?=
 =?us-ascii?Q?0NLmIOiGR6RGhATxi+oOUFIjb3EV8VUzxhoPT1+nlk0Bujnn6svb6SKNgWXg?=
 =?us-ascii?Q?KgVSVHQHTPW0iN1kCO//qaT0qD5SGH/5u92ZtNpybKFjczZWn62w80RaHJRl?=
 =?us-ascii?Q?sCDBvumKvR8qYe506wLMSxdFSH0fwHcemZSsfLIHps0NtetWcNWYtKIN2zLq?=
 =?us-ascii?Q?zBgucDisyZaVke8GeZoVxysp9xV1ZD+/4z/7XWxTFcyaGgb+BMbt3xfgFXUn?=
 =?us-ascii?Q?e3RwocAtZJIdBq3QzyhWjjTSb1me+jBQ33qN4990T/fnHiR7tER1LgvG2Ohk?=
 =?us-ascii?Q?Nngi/9pvZbIOE+zTPzFB5bWo1+ymYHH6AWgWMIzziQJ05sHXIHQ/C0Daxd3t?=
 =?us-ascii?Q?Fh8o6rk1U1MdS4OJKb+2UAIY4ypwRX86urbpqNHBB8zhx7/+auGhc/ZZq/nQ?=
 =?us-ascii?Q?IcJdBs89ye8pF3mHAE6QTSUnXXWV9SXpfjxVTMaN6+BaE6Ttg+d+xUXCposG?=
 =?us-ascii?Q?tH7Nzv5LCNMiBuA//vQfKuB8g8kHORmuMn+17sOE41ncPbrVVjxrjD7Kn1Ak?=
 =?us-ascii?Q?8dK1RpdNKk9tckOWNqlk4G6veq2MnulZuVOhVKM0Od96QQBUntMHo9udthO3?=
 =?us-ascii?Q?V+qx5whiyANBA0fk+S8Hpnzdmobx59pIJjoc4VUUv+3sxVuN6cVpdS1+NVqT?=
 =?us-ascii?Q?2S3TPMt0ne+JOvOnxC+a9iaIxm0J5uAaKF8tecE4dm/A5vu7l+BTSKHsT1uz?=
 =?us-ascii?Q?mCFoYQnjheQwzTor3OXtVXpgB/fCwnkjSB9mxXCbi8s+qer4blOpIl0/+NtP?=
 =?us-ascii?Q?2kb/h3k82Y4cxCm3gSPCkw8z+SgDMUH5iPHLv7dI3s+YNUqT+pCWoUMGJlhT?=
 =?us-ascii?Q?MkPLavYaPk/7nMjNjFL7whqFxUctQyzAVNJeEoW8tMFeDx+GAIiohvVu/pPl?=
 =?us-ascii?Q?gspQxsvbdgyYPMbDDX2bonc+8IjHI3cwcBYCAck2LOtJHh+VHq9Q5QV0LsDE?=
 =?us-ascii?Q?yYha+XBlUvnUEVsGiUXKM3/IfM1WBqjGTCzIsi+b55T/6Ncd4oERiNHnMJBO?=
 =?us-ascii?Q?sbiOdgNPtWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7B7McDpWxqe+ry0ZT4LhbGty+60k3c6kvEvSjE3cK4hHXQ0Cvz6JvvDLJ1+?=
 =?us-ascii?Q?0+78tcfj0/2CyArAj5R6lRxV5qhryntwGDo/w07fik/1vVdtvvDFRdn4U9yo?=
 =?us-ascii?Q?o8LAubzg1lsqYCJZ2xL6k8ds3Y7+SaMoiYAoFJ/RpmHxCJWtfAZPUDQXbmdx?=
 =?us-ascii?Q?ebuxsf4jeEP0+DceKgyvXLrdHlLkoE9IMWW4yuAT4dehf82spVv1zGPKgnmg?=
 =?us-ascii?Q?DhpyQF9o1HFpdUgXfOGAgXwEEGlybTxyAsNheRpcQLE9MEN0YIti0YOpiAiH?=
 =?us-ascii?Q?D9sO9198JDdGeWhtX7hg2RWgxKRnModKdQFvy1L+wgKctB2EySOK4Vfbu+GF?=
 =?us-ascii?Q?NFzxAM71LQB8Xc1J0VgZw4ql09L5kb4GEyyE0/pLTDZrwcPT8JnCouM8fT8b?=
 =?us-ascii?Q?lJ2yah3GNftCx/TADFZXvINJnsjO1tVo9F53xXFxkAizBF4YoQE8aWbYIkVh?=
 =?us-ascii?Q?+NP0HqMBBZaLtm+ZJUTky2eiyNwbeQPBPQnfYCZctKQuhY1pkVJKKaEolAng?=
 =?us-ascii?Q?E44cI2Uani5gWjQwTDxhFERI97QKU/SGPeLLGjVvuv7hcySgzBPXMW/1M8d8?=
 =?us-ascii?Q?+puaBNiLDZafVeJ+jjX7I4q5yDqD2TwuiNvix8BFsPSI1MscLOSv6qziqLsQ?=
 =?us-ascii?Q?tkcV+fgbPnzWxnTmGG9hPXSR+cTrc/R8+n8iEioBPW7/XdICLWjjowlaZjIt?=
 =?us-ascii?Q?0tYFMie8Mud7gDPEX9AeSioLRpYEojUpKeYB1aL6U/U15azjWSYm2i/M3XnW?=
 =?us-ascii?Q?hWzKoktQBXpZAeAVreOOyJmUAC3d+JZ7hLuxOU0dBmIP1L8wmSFBF9Etd24W?=
 =?us-ascii?Q?0R+jJ1G01nOFsIvjOV6tntw9OjKfKvDzLMQqZm5+ght/s1UpPweJ20DIQpe0?=
 =?us-ascii?Q?T1lVPbpVKMqHjtwpTtfxfcAjsx2ssSgK6lY8N17QmS+eXER8r/Eucyfjclud?=
 =?us-ascii?Q?Czl99PDw8gyUDEandB11/2YQ9pgsW4dPV1OmTIeaICpi8KHoEwSdgJW1s2Bs?=
 =?us-ascii?Q?298BVsd99IuPAHaz1jGyE8EQkBgzaGrtDcg9L6T/+SqoK58X+pI+GJ0tUkEm?=
 =?us-ascii?Q?xz9sJm3rlMgNKEG88zILnadCHdYyXOtDHIhgCaLgsSwd87P6L6xCAYewDq/q?=
 =?us-ascii?Q?5g72sPhKrTH1zPz0xyf6H9G2nQZwqv95iX5eDkAzrax6H1QyQkU7ei8ygRix?=
 =?us-ascii?Q?Gn+ZC6e4/EtPt0gGn/fqCaeagqBpjdPyb0cK+vUiPybWPdc7nz/PfqimsqkL?=
 =?us-ascii?Q?7hK0YBR8NjaQEk3+6z2LDsS9wLO9y3Oh5M0hsaNTZ674bSnTKZZKgMifzaAJ?=
 =?us-ascii?Q?tMShLaljDcxB9PudIXN9WFa6hW1HoQ8zrDdsRhmm+tjLUxjJmnUNdvEhsARa?=
 =?us-ascii?Q?NNBSTXgAWalqd7Rno8s0tKHcBYPhvv3EZVrx4jqh3eyzxbSYdb1eVYgYp9JT?=
 =?us-ascii?Q?vBxQTiRksv+7Z+qVx84Mk8WfaDk6NmR+WpGPsb7Ol0G8CcU9e+5N8QZsbBMO?=
 =?us-ascii?Q?xDlHdXuqY4/J6Xft049cbTaxgEUAOyVzJwHUdIgSW+43MOp7Ahb76G04Uw7T?=
 =?us-ascii?Q?nuPJ3zmXlXjz52Idp0ut5yiYruX1BTwl0F3GRZNq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afbaa1f-2aa5-4647-5919-08dd9e7a93db
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:32:26.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2HrsCvQpYhhgzqzNdaq1IhBTjfBC+pz8+EoQz3WLhx/U+Hoo4YRXjyqMMl2w5s/Pcz79tSxAdw7netbpszEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

The PFN_MAP flag is no longer used for anything, so remove it. The
PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
also remove them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pfn_t.h             | 31 +++----------------------------
 mm/memory.c                       |  2 --
 tools/testing/nvdimm/test/iomap.c |  4 ----
 3 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d91482..46afa12 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -5,26 +5,13 @@
 
 /*
  * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
- * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
  * PFN_DEV - pfn is not covered by system memmap by default
- * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
- *		 get_user_pages
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-#define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
-#define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
-#define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
 
 #define PFN_FLAGS_TRACE \
-	{ PFN_SPECIAL,	"SPECIAL" }, \
-	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
-	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_DEV,	"DEV" }, \
-	{ PFN_MAP,	"MAP" }
+	{ PFN_DEV,	"DEV" }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -46,7 +33,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_MAP) == PFN_MAP || (pfn.val & PFN_DEV) == 0;
+	return (pfn.val & PFN_DEV) == 0;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
@@ -100,7 +87,7 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline bool pfn_t_devmap(pfn_t pfn)
 {
-	const u64 flags = PFN_DEV|PFN_MAP;
+	const u64 flags = PFN_DEV;
 
 	return (pfn.val & flags) == flags;
 }
@@ -116,16 +103,4 @@ pmd_t pmd_mkdevmap(pmd_t pmd);
 pud_t pud_mkdevmap(pud_t pud);
 #endif
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
-#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return (pfn.val & PFN_SPECIAL) == PFN_SPECIAL;
-}
-#else
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return false;
-}
-#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 #endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/memory.c b/mm/memory.c
index 4919941..cc85f81 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2569,8 +2569,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 		return true;
 	if (pfn_t_devmap(pfn))
 		return true;
-	if (pfn_t_special(pfn))
-		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
 	return false;
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index e431372..ddceb04 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -137,10 +137,6 @@ EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
 pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
 {
-	struct nfit_test_resource *nfit_res = get_nfit_res(addr);
-
-	if (nfit_res)
-		flags &= ~PFN_MAP;
         return phys_to_pfn_t(addr, flags);
 }
 EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-- 
git-series 0.9.1

