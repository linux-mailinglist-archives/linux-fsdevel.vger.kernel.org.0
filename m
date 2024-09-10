Return-Path: <linux-fsdevel+bounces-28977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B6972807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6F4B231DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06118E756;
	Tue, 10 Sep 2024 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lr7jpi/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDC18D649;
	Tue, 10 Sep 2024 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941724; cv=fail; b=GA71KC5PVaPGDXY7jOLHc7uLcS8Ht7MM3g81r1Frpv0SHL3wOvN/YhwsPSdNi+FNJSBYpJujpL3dHhsh07scghtr2OyrRNvmwBXginrbSWY5LCyMc+JQ3DEd+2+op6NejTuRINieEQOfCgRS4G4mOZkLm9es/5frHG8B+FRuXzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941724; c=relaxed/simple;
	bh=P8hj8duirPqMbwv4st4UqVI974aAMGWoSxucp+HHAyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnCOEBepaUdrZrQKnb7r5WLnd8P1TphpmTSRRRhfemNasCGbM66Dd9DjC7rscI00UGIAH13KUbm/Gv9GLPMDV8WIWusTjqpvCCTWMh4NysLFxBPci16dbr4IuzJfZ88mQvwbPMES5QRwHq8Oi8WW0xFPnC7MObQ38CtskSGiTwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lr7jpi/6; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVemABZIZThPaR09NY40UZOvIqHoiesl5ZNh0FBob/FonkyBWycrHaU5ipwh2JTWluOOsHkKOHPvBuL3gjPkY7oo+y9RISSeg0LOgtpqIeLhyIB8BrOr5026xt56HUAI51vOTd1aNAgJMo7VMCTp1+w4JOO2jeEaEp7/mbxd1tPK7W2UPOCm3N3w8cYE05eC66Gh3DNAGQobxvJSVjY8HXKn1inJZrwEEb8EIKMQGKvcVLBwiufsHU2DPS841wgEqDQmto2aT4c9XGF7cNzHO3Rb2NTf5QmjC9uVd8Ugm3PVtKbohfHJnq9l9OhkyB1WGKcwGGZTeFSPi8yC3OKsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44/c89HYmWXuc2I8zGYG6pChU962eRsHc5iIPIY/3LY=;
 b=c+mq6fuamCE/tHlRkMn1FouhTffZ9kNN9cQui2slEOCe+lSqSIZdYZxY2To6iTxChranpxUDvSX9J3aPmWTmw0iuSD7fqmsDxaPH3LPu0mlrc5Kf4RjrYibaahedbi3iOTBhI7ALXGwqySOJyePXaEP5ubS1DgzlFYH6sCIeLOqcTBToKwicq8p0gqw/PF4ajLhEI/r7wlFA5huYwxo6B+C2hYVyQIw4/T3rKltfQruhKfgO9FWdNl7e/YJkuhxUQQ0cWY/oEswIcW3pNN/HRnQOEejvIyXMvcjyTbBybj5XvGGduApmuEnbxZ7kWiZH69Uea9NmdIm+1xEipxKx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44/c89HYmWXuc2I8zGYG6pChU962eRsHc5iIPIY/3LY=;
 b=lr7jpi/6v5w1PCtw63AaJp9L3qhf1QIVAzexT9KUftGE2lWKBTtsxh2ZiraW9u76im6zz2Clr4yS5xXMfAi9CfubXbkinstM+fmOnvOIzGOYn5YaMJBuy+AulXq/qbqXT6kW5dPqlrtAXsRxPAPEFTtMc/2nqh2bhLARF01zK1rqd2o7wLF1V/yPJ6+QoG7xqL2kUx8HO6FYBA9PUnstl1QirOy207mZrNklyb0D6d2e0LZnWZIW3U2GMlXs0me0XeBOZVURMIk+WkcwnTKQZ8+88knOoeMngqF1SFjbvZe+oeSeUVEs3pd6aimLs41aAw4Ak/Edhs8V/ltifhdMkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:15:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:19 +0000
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
Subject: [PATCH 05/12] mm/memory: Add dax_insert_pfn
Date: Tue, 10 Sep 2024 14:14:30 +1000
Message-ID: <110d5b177d793ab17ea5d1210606cb7dd0f82493.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::35) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a32106e-d821-48f2-d5a0-08dcd14f2e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYHtU7a8jLIt/MuBG+b8ChbB5Htn+KST2CrbhqYChwiM4iKd2w4r6a1cx+ZO?=
 =?us-ascii?Q?VdT4jchb8Xa06XqPhf7gdEjEFyMZRpkPARGsEE/EZ0oItIGQVhSWjGBvYpJS?=
 =?us-ascii?Q?GvLTBzcW+HMto4B8hdGo0P9gP6M+4cOxhftkRRcfxUAOUKVi2n9JEqtgMESY?=
 =?us-ascii?Q?hrkjH90eOJOxcMIV53y+MPqVddgL0EO+f7Zo/mSN/mBXHC7lxXrqSXTvkeab?=
 =?us-ascii?Q?mzNieQWoXoo5Xv1Uej7ucJaRzJMJpJvZ5EPNhDm0WhC20BZ5vQH3+Rz20hv1?=
 =?us-ascii?Q?F7GK+Q4y5ku38V5uZFNWORn8k/OP+qeP5+3rYR6HgIwdCcjM2GVwM730+wCR?=
 =?us-ascii?Q?Bh76YwbBn0JDjsLzCDxhVvUILwsafolEQPQkrpz+ZBWRVNwKtdYVth2Jp4U8?=
 =?us-ascii?Q?xJQHXwZAintWYT5w7ah8mBCiDWMtq3lnvMO86sjCzubC/fwrJQcAl/xY2O81?=
 =?us-ascii?Q?n6VrlCad3oDkzubZ5WxWC1tcIV2ehxnz691gi+dCc1lVAXZFgke91d1xSIkd?=
 =?us-ascii?Q?AeHxXI0+mx86UN9LBg+t3b6zP/FlClhSl9W/GdUay9BVjISfETsw3/nffIeF?=
 =?us-ascii?Q?wPr9sOJEWm9UC5wrq8CTxnHEEB9qAR0UxH3+Ge9EX1YT3ZrMaqUgswelEuxI?=
 =?us-ascii?Q?g9mgm3YEypX/csVUv6wUJZq51B+3ixhrrA3gvyWdY2dj5PYzqyGLJl7h1xYw?=
 =?us-ascii?Q?aXl82RWKLqCXNHL7uMWZ7XtR7EmWEnpdUroCDV4xsCYUp0meizINycAdK8st?=
 =?us-ascii?Q?r+UQl1MZ0+M7fMKKOhW46bRIpRCVWOeOOUvCvc3eMPawn6r517CqvgveszOs?=
 =?us-ascii?Q?5Ak4fq0xYoiuQcGQ7tl4CoGZknRBXAe+NvGanz6fROXRJHTETy46xvICDY4w?=
 =?us-ascii?Q?WDJNJ6g5XI2KPsB9I3AlanHYuZWtZW26VOFxPVUD71p/+8LdzXKcW+GbAbwD?=
 =?us-ascii?Q?onQrNKGkedPtDPLH9u4AED3PA5vzjDcRSZcxRlhBnl/7vcjTguwKKO7i1tum?=
 =?us-ascii?Q?4T29zmvYD2ZGPmWCn9rE9Owu/A4LYXLCgUnZO990BxQFWYcztAaRC5llLjea?=
 =?us-ascii?Q?cmbg0vKftkbA2LrMX0RgK2Nw5h6O1dWfk0cxVpxOFTlkSEtvagQ4loS+n5WJ?=
 =?us-ascii?Q?FChSEChYkGTa6ALDqNUKg1jvrtSFV6H2KXZQLY+ZdVEYNHCUsdOyGYHEFcIv?=
 =?us-ascii?Q?zSe6ddNykGPEEAFYaZ2BIyngaZLVSvG80zUHT6llwMw+cW1RjVgmrqnmRISl?=
 =?us-ascii?Q?LU3Om9VHw9qBcfKXVujQSql5BmEFfebKhjgAtNgcP3JXIYAp0CkTOq9ADoQi?=
 =?us-ascii?Q?DA2+G9O4sbNH0hUqBmPaR3dP2sMVQjiUPGikbufvXpQEzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fm1AMGUfi0XUs52JZf0rz+bge8SUQRMukaoO6sIPARxe4n5otAObBKpyu3W?=
 =?us-ascii?Q?1n7WGCKXebBq4Ky8M2tw40dTrJGGqEtpOaIbdirmJh6XWMd1HxjZNeNP/8Dg?=
 =?us-ascii?Q?hHjc19eRMiKCU9ghM2snmuSkeoFDD6vXqrt7UmpYdEUD8NvYgxkHwAWoOPy5?=
 =?us-ascii?Q?t/NZpi25GcVAtimDAx5gcES0ibzRyI4dEdc7aXKGoM6WhmYQIV8NFKMxCULp?=
 =?us-ascii?Q?IBgVUiN77UfGcVSsofsPvuoxRhvlOzTUIACAfn2Gfk3W5rE1uZHB+0I2zFlG?=
 =?us-ascii?Q?A5LUsQyxYI857LjGlpNMv13fyMF6tLHN/MvcrctRbO8nsSleDu50EmopoPXb?=
 =?us-ascii?Q?AyoccCLeX5P1Ng1vyLzIws68oF9MKR5alWXi/VafbI4CqxpZufG4o9dgn5I4?=
 =?us-ascii?Q?hC8bXKo9/fOAoTFEN/l8tVUbZap0c4/obrDaEW8GhFh12LyiCVysczneHbDG?=
 =?us-ascii?Q?4dKcs/CQTQ9HC5H5oF1/OVYWcx0wiKvDibDE2BGef9h9Pzv4USGKLy63VSd2?=
 =?us-ascii?Q?bWhwx+lB3PI/kCAqxiCF03IQZY1rhyCMGLnGC2TyZkQX5oYMqKN+wG3p+kWL?=
 =?us-ascii?Q?4bWW0DhX+yEAvlBd6taXhgSgU/rnh+op55XcZ/xbqdAuyxK5fbonB7nnn2aw?=
 =?us-ascii?Q?PGBOHHZpTaKbcM9Fg93YhOZB/MW7SLNfzERbNqWW+PDvEuIqOC1oa2YCkdHw?=
 =?us-ascii?Q?u6gNSYff5yObgIKp3SMjRAt4SVtbD6RbTSAQU+xF17SBsd8nslmjjLGDexDB?=
 =?us-ascii?Q?nG75oUYNZ9BBKsDzdlZn0DuEn1g5a23v8I+Fe26RCnu6wqitw09Iq8bcKPWZ?=
 =?us-ascii?Q?Fifv3CPku+gVGmawV6n+vbQ4cZXeITRlWvPudqsjcAj5i08wrioZzCqnTB6o?=
 =?us-ascii?Q?wi1NY/mBeivSkAg6N6CtPF3lkV5oygoTJwrBt4gLnje+7XFBJ6bCuOCm865g?=
 =?us-ascii?Q?Bwq5u9Xrk1DNul0QtknjD3p8h6oGKT+HaQtnmMiosR33MbntLMOUJ4wgKF5E?=
 =?us-ascii?Q?Wfdgkrnc7uxd/ZOrRg0bRjBnmVyMLSi8oobJqadcSMVxwhHIZh5ZFEEMwA7z?=
 =?us-ascii?Q?X8fmMuyk/vs5ToqbcWA1pqITAz1xrxaudX0jgzSzr5kcBfc/eHKutpNqvFCf?=
 =?us-ascii?Q?7NY65Bd8Y3benNwUC94FZThYtjkhUVnpVLDXBVPYsAMLoGa6avYzo9teJu3G?=
 =?us-ascii?Q?BTuHTaKZB1kcv/RS8SdgUckZILeLKzsgcXl7txynyQNuUDktfX5npD/zUBeh?=
 =?us-ascii?Q?X6n6hNsW9EVAIxr1LamlEF/Q4D2W1BL+4K9yP6bFRXusno1A1zcvm2B3cUpt?=
 =?us-ascii?Q?wwsoI6lD2GBsTmq3KB6Z37cH8K/AI9uXcxRq7TazLN5s9+JS7osha67dg13C?=
 =?us-ascii?Q?OSAddanHsxMI7IfoYfYYQOuXznxposOk5mwxrJQOpDfQErf3Ll/UHkc945br?=
 =?us-ascii?Q?K33qUDs55BLoZTGvinpXPmvAnlokvgPj020XkvWLVCeSyTsDNoHuQslv1Mjv?=
 =?us-ascii?Q?EoDM2+xSiQxs9RRaJlvFa7+AcFeWFYcqOAMz42EG9VZEcjSgAgv3R7JY/Yr0?=
 =?us-ascii?Q?TBeayITiJBylzzs+msSazDtTJivcCjbucF3PsU6v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a32106e-d821-48f2-d5a0-08dcd14f2e4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:19.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrD+oo8TgBdRf5WfNZocgy7YpSi09mpOuFvt+6m/W4jpWAksLIQ49wwxXSOW4YqO+Kh9BVzpdCHqpFjQ8xteYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
creates a special devmap PTE entry for the pfn but does not take a
reference on the underlying struct page for the mapping. This is
because DAX page refcounts are treated specially, as indicated by the
presence of a devmap entry.

To allow DAX page refcounts to be managed the same as normal page
refcounts introduce dax_insert_pfn. This will take a reference on the
underlying page much the same as vmf_insert_page, except it also
permits upgrading an existing mapping to be writable if
requested/possible.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Updates from v1:

 - Re-arrange code in insert_page_into_pte_locked() based on comments
   from Jan Kara.

 - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
---
 include/linux/mm.h |  1 +-
 mm/memory.c        | 83 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b0ff06d..ae6d713 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3463,6 +3463,7 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
+vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index d2785fb..368e15d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2039,19 +2039,47 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
+	pte_t entry = ptep_get(pte);
 	pte_t pteval;
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
+	if (!pte_none(entry)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/*
+		 * For read faults on private mappings the PFN passed in may not
+		 * match the PFN we have mapped if the mapped PFN is a writeable
+		 * COW page.  In the mkwrite case we are creating a writable PTE
+		 * for a shared mapping and we expect the PFNs to match. If they
+		 * don't match, we are likely racing with block allocation and
+		 * mapping invalidation so just skip the update.
+		 */
+		if (pte_pfn(entry) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
+			return -EFAULT;
+		}
+		entry = maybe_mkwrite(entry, vma);
+		entry = pte_mkyoung(entry);
+		if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
+
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		entry = mk_pte(page, prot);
+		if (mkwrite) {
+			entry = pte_mkyoung(entry);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2060,7 +2088,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2073,7 +2101,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
+					mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2087,7 +2116,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2223,7 +2252,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2503,7 +2532,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
@@ -2516,6 +2545,44 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t dax_insert_pfn(struct vm_fault *vmf, pfn_t pfn_t, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t pgprot = vma->vm_page_prot;
+	unsigned long pfn = pfn_t_to_pfn(pfn_t);
+	struct page *page = pfn_to_page(pfn);
+	unsigned long addr = vmf->address;
+	int err;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &pgprot, pfn_t);
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * We refcount the page normally so make sure pfn_valid is true.
+	 */
+	if (!pfn_t_valid(pfn_t))
+		return VM_FAULT_SIGBUS;
+
+	WARN_ON_ONCE(pfn_t_devmap(pfn_t));
+
+	if (WARN_ON(is_zero_pfn(pfn) && write))
+		return VM_FAULT_SIGBUS;
+
+	err = insert_page(vma, addr, page, pgprot, write);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(dax_insert_pfn);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-- 
git-series 0.9.1

