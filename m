Return-Path: <linux-fsdevel+bounces-38813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40AA0877A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E7E3A7468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA67209F35;
	Fri, 10 Jan 2025 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nYM1hyYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5420967B;
	Fri, 10 Jan 2025 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488921; cv=fail; b=Hdd2Iy+hbCk+46iG0DgVtbSebPQpQ3HOErRniFIkv6T/UL3dBX4OawFBt0drYri2xRLknxKZ/r+q1IXkKj43zm8jN8q/tcaQ3cIk+v/dilJJ9zqLSJRF2gHmvXg8ZNsb3NzLd1QhzW489d+MTsKsvOXJKrHqgQXVuykJ1JupFBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488921; c=relaxed/simple;
	bh=I8N8ykoX+IlHs1Dz/s3j0FUyPTi53pkKwSnEOijdpFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQAZ7tSsmdXaXCwOA9pInPzZVUBcnZ48/64CvxWvkSCJUEAy6Dff248yl+Sxl6/h/B4Ugvupx3+o6f9HJzkA+x88XY0uneumxmB2bXRAdyKwbp2aMjdCd/tmBwU0gBWbbf+XYKCJs2u5SXUBKh5gvciChp5wrin75F7nHHrFIik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nYM1hyYq; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iagfebz39dN9cQQf/PcA9LXjPiVOYw8u+qIJxGJ2C5nfMPnaGe6KrCBUXZF/cmwOsCaezOmQrWjGAVQr9TM8ZbOM9DBkGMmyPCjOxAbUxrXL2yvig+FCuaHtwBHRr4XqnZy3g6o8nSYSL3AvVDLWjhYR9E/+Kh6dY2vwGTw5D8b4WcE5ntaX6OAB5BZz7QzWxD3I+efTi7MY55u0IoiA0vMZHayByunVKk0PVQMiQefF999GOOOtq/IUm+WMIptaCPqN/NECNAaqygPWQTMi5paSUvKW1aVdQtEOurOMr0jg49ngjkFowq6XBzrv3ZxHzrpyXrK3EYCm8HfVm229gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA6IK/Y2KuCTn5DEQhgF4VkZcX2IeUmqIqn2SXK5C70=;
 b=R2u4Au46y+lOz0Am4MowwcuIBJkSyMuvolMHEEt18JzdPth0ykCurt0WsfNMxWoprDuYKeEVwRcOJMmo0x8lkkesMS4Y38BXp0pi04QzeRaAZfa3JPn25Yud0SgZ/cLSQb9KmK9lAh/VORM0bad0yTUgupMos49NTiGXTQc9OdtYjPWn7esHKRMIV/CKXRJtxCcH/aMjiBRnC2CTZ9scRduAIXujdKPYt00ap/uh7YqgpPXUzfwMnqYI1xHvlpbE+ZiB+rdTM2hTxMIkHP8HOMBCZiucDzuc83tzIlpQRDprPNiTxYvqutFqjgjRHDM6p8MK/vUhXdxIGcG2U47DaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA6IK/Y2KuCTn5DEQhgF4VkZcX2IeUmqIqn2SXK5C70=;
 b=nYM1hyYqKwpV2+ChOz4dbZFYhBZHrm7o5FHvfScTNDcRfxgNzGGHJ6aqbW12E5wPkYwbOXK2Mf3z3nS8aMhfD2unWN3gJXVLM2fMQLD3EyHSlBR9VrxyylTZiCQJ96vUyhiPGPNbCQ45W1F2sLkCNUHWHVkWFfj8JbDtWzUysUX9jC1pcaZXco/Zx8UY5H6V4xKbXl1ukgbCXDAA4Bf/hfUaO+xmaB3cVpbdGFxr8JWGJr3mmT34Qpx/jK86m6myGGTWw5J53ldvw5mT9DFUoFYeEjLF5r/piwfFW+pRgaDL5AtmYRSUEKIFkGQaC4Xhjkgr0fSNjDeAmMamQSHfnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:01:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:01:57 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v6 07/26] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Fri, 10 Jan 2025 17:00:35 +1100
Message-ID: <704662ae360abeb777ed00efc6f8f232a79ae4ff.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0053.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0babb1-de22-472a-5ea3-08dd313c4a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NsyHrZgV8A66cwzja+f6rM4hf2kdo/tEQdS0xAnS3bC526UpwKDKdUXnHxF?=
 =?us-ascii?Q?EZ+CmXIddyBzZDVYPh9YJSNvGp5gtebXdkmap4XGDR+2/UX8SzPxCdMm6+jJ?=
 =?us-ascii?Q?0qqtGdudsdjmokldqPNyOte6B52ylg2FrkaX5PGvBo30k3rGtJ/j/krkGTSB?=
 =?us-ascii?Q?i4ziE8R+GO/u1c0fxpZVg4HYiS/kBYsO3Mbefzm862XtlQ6kUcHuoijBs26U?=
 =?us-ascii?Q?CQutS/Pj/2ymsWs87dfGWelB8FJsOy5Opaf24QPcP18wlYzHww+n4FOGA7Az?=
 =?us-ascii?Q?MS2neCpJJ+P3ivMrokVtJWXRIANXt/u1T0991oWGnLQ62D2z93hW213LkqUw?=
 =?us-ascii?Q?U5k7iqHk9FTLlbWJkDrM0TMkFUIqii8c6d/FWQE3gWty27h037P6JzeWjzKO?=
 =?us-ascii?Q?6Hx1CkNq/CxEQ+gJViuZMg8EGU+U8tV4nThQUWp8TZbP6jQiT34qgws8fyr+?=
 =?us-ascii?Q?+n3HSMX9wuKxrrmwt/39f15Mh1wdIdDIb7SMIyWIc5j3OguL92QmIC1lnurX?=
 =?us-ascii?Q?ShXtwiCSAWwNY5mkr8RWseTXX/xOcoc4zHiZSPfB4HP/UhjeX4ziF9tYuKE+?=
 =?us-ascii?Q?kE2MhFl+RGmyHzoTTVbjCPW2NF96WZmtDUfdHD8jFX9gJc8w+/GBoGORfEfQ?=
 =?us-ascii?Q?gJYy0U57fQEUcdR9hLrk8EyLYZY78IXeHjNbJIDoz0uZ3IACcBVgeP9El48o?=
 =?us-ascii?Q?awHb++YT/Vo/qIZtMkT31HheY/gaDVd3+lCgHW6/3fpYjWjgBjY8NKnYzVb5?=
 =?us-ascii?Q?dGZLd298nxaBL6grRtnld4UT3rDzsxwUxQTnh+KylmgGX9xUJ2sgPNYwSoeM?=
 =?us-ascii?Q?tVCpgY6DjyhmcarXpk0ys9h2osVqPV9/Rj27P89WfKOEdO6aGtyUGoN6VOC3?=
 =?us-ascii?Q?wrC7HzWa4XF3VgPJmPKA2Ex+ZQ8I9bNKdrLN+HKn4kTj1hu0CjX3BiEaOHln?=
 =?us-ascii?Q?GSdiqUsgB8CjnXaCQ92YoODFGQ5zvHfd2i6Gmt5kGsVj941eIr6z/G6vngmA?=
 =?us-ascii?Q?z0JTFGwB/LayTuYQNZ2PlVacifaktqXJVRliTaqFEbmTKnNT8CAF76fVa4C0?=
 =?us-ascii?Q?yrlLUH1G7/0dZC9dSumUBa2ZPtiF1ku4jEP0QRViI7g0NHxvnqI+4+RIjpAK?=
 =?us-ascii?Q?0CwybEN9md2EIiYLmum1qVyWdnON92he1foIFsFpEU3AmswXhpRflOTOzFBz?=
 =?us-ascii?Q?IWmjaGUj8UWiv2L17u45gbr8bZuGZzv4QEpGX/VuYzLrAyRr8Pah+VUs4ele?=
 =?us-ascii?Q?uZC61HjmkjennVPLQEGvfcQ0DJeReAVqxu6opk4q3/A95DmDddRULd2xJKoi?=
 =?us-ascii?Q?MJOdxhnfsW83+XLwbJjrLj6nsRIAjCE///ZdgBWIGX5bncVQfb4T+O0IyPmw?=
 =?us-ascii?Q?53LMran3wEIiV9b+Odf0XaUrmEBW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uo5TRXkAe380qdvgTsh4fBZhQTQdd+ZaUcQFK4zbJNVQ5o4o3RqK8f3rG1nA?=
 =?us-ascii?Q?htCEKYKif7W0694eC9ld3mu5z3T+XSOyZ/HG+O/a6/vWdQGdB5aQANBgnQyg?=
 =?us-ascii?Q?biZeEJA03RB+dGSYMsaHPUn4y8/mbvvoMwzS2HsoD2waHiMNksfpU5P4CpBy?=
 =?us-ascii?Q?i2Tf7p+xMBXieMTvEU0ivd+xjPPKs/p1UNdWc/L8A43XidJ3JAQE+InqbWCj?=
 =?us-ascii?Q?1Un4MksLuWqk7oxu8gn/gFRH+9p8ug4EzJEpgGMHe8ngDuuDaFqxCUNsXvO7?=
 =?us-ascii?Q?jfyNzYOjK+YtPUjzMfz4vN/BH6CRFfKPPrrPX2/AY+W/JzTx6nFTHuOoji1z?=
 =?us-ascii?Q?ov4XyysMoVRggaBu00rM+9PALYYbhbgMMnR153xu7GEeivuajQaTwzaTLQws?=
 =?us-ascii?Q?UZEL99FupZvj1VkqUDLNgm3N370oYTxYdFhOW9jM2St/g7IrSj5IRDAR7VYt?=
 =?us-ascii?Q?GNxeqTCfjg591q6MUQanCrerAQcQk5AKvBc2pU34nQW4F2BnXm2vE/8g8cla?=
 =?us-ascii?Q?vhCFWDe4j2T7Je6crb1O7zHEtWp4negK0LbCTxe3c0pEwBGkquxpYaY3kgHu?=
 =?us-ascii?Q?2EbOAc9FqJ3mJFj6C+wVXOWnP8rzIScWUcrcHZ24sv/IKRBOw3HQZQGze0/9?=
 =?us-ascii?Q?PbGE0d6IjnisfQss6ocIijENWlSnqFRgVd/yAELj9eBD6W0xHee8R55K16lV?=
 =?us-ascii?Q?sLWqb0lvGnwrDHS44xnEuAY3mwJceS6CRzqwFXjVuZLul8B2t4FEbqIq1Hd3?=
 =?us-ascii?Q?jNhRAqYXLYoMcKBvCG0XLknQHz4kpMG8wOzj3HJhinZG3SD0sx8YV3D1yJRD?=
 =?us-ascii?Q?rk+z2/w98WEtB8fv0HpWIPQrbsfdbrRwKvmRfAXTtNDGsGxTrcgB8h2JVGKn?=
 =?us-ascii?Q?TgKHwlDz3Ap/cK3Xeve6b6RgwSmLLypNjzyxUu8bmktyReNBEYY+3J5sGMon?=
 =?us-ascii?Q?gPDr8fgSeuO3RW0idEPpR2IXmEujnZ29Q9zXAqYpsWZXbqbydiZQk9gbjyix?=
 =?us-ascii?Q?NzOVh1v9pCJyLD0inNAfx2SlvBi/sj3McYYAAwuJY8pX6X6xWsEmH+MPN5Qh?=
 =?us-ascii?Q?Fa3dyItYIvOZqy0H7PONkbCQRZB3veq9wwo4emaSTy+qoFQJmjlvviJbQkZT?=
 =?us-ascii?Q?TS3hMtWDZ9BVd8JZpye3WSA9b+C5dHu7TNMp89+QVBf4xIe2PZ0EX5GAV/m3?=
 =?us-ascii?Q?XLPHTM6i+1M9FIWreVF3C3EQXW/EuvoIhloy36Q+OdOvRRp0jTY7k9N7+vtg?=
 =?us-ascii?Q?2XvLfsBnqkLSBPulggyuqGj2WHR0t+m18KE7ea+W3PCb9M+ms2fb/gx2D5eA?=
 =?us-ascii?Q?CqPWs78kX2IJQdhgnGJAIlfZT/IpvE3TaSKgOYd4JUaqTWLhuuU0UVm8Vv8X?=
 =?us-ascii?Q?AjoGrNmbR88jgJ/hun617Av8YMY8mXiYTOtEbGEib5VkyXZc4rZKLJKqGk6M?=
 =?us-ascii?Q?STH97xnqxzzHp20p1yugJsgob8K/Azk8/HEHiqE1Bq0yoRyxjkulHdxpkTlf?=
 =?us-ascii?Q?Dx8rb7j0EPNFbi6b3CC0PVr1qJN3xudyKtNP5MTylFOx0mrUv08LvTG5WB/U?=
 =?us-ascii?Q?vV3/wMCloYVhS8nFlZsT1cNSqcHPeUHPMKjx2S7d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0babb1-de22-472a-5ea3-08dd313c4a34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:01:57.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHInXyb+w8vFl03FW3LfUfWmbraDhWbV6W2eallRKEDOtaqQ6lpLq8Cjh/XbaF0yYx3zFLXfLVLPwobzd1/ivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

File systems call dax_break_mapping() prior to reallocating file
system blocks to ensure the page is not undergoing any DMA or other
accesses. Generally this is needed when a file is truncated to ensure
that if a block is reallocated nothing is writing to it. However
filesystems currently don't call this when an FS DAX inode is evicted.

This can cause problems when the file system is unmounted as a page
can continue to be under going DMA or other remote access after
unmount. This means if the file system is remounted any truncate or
other operation which requires the underlying file system block to be
freed will not wait for the remote access to complete. Therefore a
busy block may be reallocated to a new file leading to corruption.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:

 - Don't wait for pages to be idle in non-DAX mappings
---
 fs/dax.c            | 29 +++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 32 ++++++++++++++------------------
 fs/xfs/xfs_inode.c  |  9 +++++++++
 fs/xfs/xfs_inode.h  |  1 +
 fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
 include/linux/dax.h |  2 ++
 6 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 7008a73..4e49cc4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
+static void wait_page_idle_uninterruptible(struct page *page,
+					void (cb)(struct inode *),
+					struct inode *inode)
+{
+	___wait_var_event(page, page_ref_count(page) == 1,
+			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
@@ -911,6 +919,27 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping);
 
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *))
+{
+	struct page *page;
+
+	if (!dax_mapping(inode->i_mapping))
+		return;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, 0,
+						LLONG_MAX);
+		if (!page)
+			break;
+
+		wait_page_idle_uninterruptible(page, cb, inode);
+	} while (true);
+
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+}
+EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ee8e83f..fa35161 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
 	       (inode->i_size < EXT4_N_BLOCKS * 4);
 }
 
+static void ext4_wait_dax_page(struct inode *inode)
+{
+	filemap_invalidate_unlock(inode->i_mapping);
+	schedule();
+	filemap_invalidate_lock(inode->i_mapping);
+}
+
+int ext4_break_layouts(struct inode *inode)
+{
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
 
 	trace_ext4_evict_inode(inode);
 
+	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
+
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
@@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct inode *inode)
-{
-	filemap_invalidate_unlock(inode->i_mapping);
-	schedule();
-	filemap_invalidate_lock(inode->i_mapping);
-}
-
-int ext4_break_layouts(struct inode *inode)
-{
-	struct page *page;
-	int error;
-
-	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
-		return -EINVAL;
-
-	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
-}
-
 /*
  * ext4_punch_hole: punches a hole in a file by releasing the blocks
  * associated with the given offset and length
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 4410b42..c7ec5ab 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
 	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
+void
+xfs_break_dax_layouts_uninterruptible(
+	struct inode		*inode)
+{
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
+
+	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
+}
+
 int
 xfs_break_layouts(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c4f03f6..613797a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -594,6 +594,7 @@ xfs_itruncate_extents(
 }
 
 int	xfs_break_dax_layouts(struct inode *inode);
+void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8524b9d..73ec060 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -751,6 +751,23 @@ xfs_fs_drop_inode(
 	return generic_drop_inode(inode);
 }
 
+STATIC void
+xfs_fs_evict_inode(
+	struct inode		*inode)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
+
+	if (IS_DAX(inode)) {
+		xfs_ilock(ip, iolock);
+		xfs_break_dax_layouts_uninterruptible(inode);
+		xfs_iunlock(ip, iolock);
+	}
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
@@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
 	.destroy_inode		= xfs_fs_destroy_inode,
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
+	.evict_inode		= xfs_fs_evict_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ef9e02c..7c3773f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
 {
 	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
 }
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *));
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

