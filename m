Return-Path: <linux-fsdevel+bounces-50036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C0AC78F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067A11C08607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77725DB0D;
	Thu, 29 May 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+cvgG9b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC457256C93;
	Thu, 29 May 2025 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500384; cv=fail; b=aWTT9KU1eLIFFrbz5I1zyJdYfShz5lMzYqjYU76W+8ntlknn4oPEiwxtUoXCMZitwpoxOiSCQ7aDVv9vsZbw+gXQQ9dExqD1m0MUmHqXbVLQoBZz3R6eyV/G7Vwtg0nEfv7IzzT8VdTfGuRtmKJNud7Dj/fA4ZzDcfnlK0pT4Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500384; c=relaxed/simple;
	bh=jJrIrF5LKZgGwa700HgoSaR1piGFeADgfWqENWLseqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtcRlO8lvD7QcThMYjWRzqfL/045cMG3+JlHaoLZyAMTOMMpSmNfqdaoF6qMNDwybKMfUfjlMzFwPXK8vjYA1DZQ0nSEF2+ds59WAJ3otMtCUM1XGlzJDPDuKHHvJefgNoOC1ur18MjT8pxsYnLqFoRyWbrQbzmawaknVW4dv0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+cvgG9b; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/sn9jy12/KF9XFG27s1I6Vj+san1LoQMFC4dH7jPzRGes6SBVrKjMy+UwYWdpzvqmGisP7YrYh88EXLrKjt2xsnvJv4n12IopdPxoucdnxOxw0NVnP3LiHVH04osdaOr8xlAPuATWhJb78x4ecwZ9oxxFSzH36LIcgFkkMsyxaa3tIPefBH98+T/d8Mq+mESE9Hf77CmfwFEJdYWlz3Op1qZ1ypMb/R995TEFRAYaglqfxV8vU/UoGcc6MQ+i71MBSSIe7+yfcMzrXi/vkYVPv6Zgenc9tZBLtokAAtY9Pshn13j4Hdhq/n7PlhHjOfC3I6gPfGo1tyQilJCqwrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1593u5AIYrFrvsFXXbhd+TIFTZXEgrgaQ8p+Db3PPk=;
 b=oXkJ/3HBfWk9iTPMhpxprr4r+NUUM/nmc9+3xE1mWTuNAjR3CXJbuGGKwMzPFJQMn2w5DhGm+cC5ZZZ8bh7KfsKxDGptCxkL3L5v+rrH5LnIOEIXlJT0hAeRNC/Nnr8KP4m0+mzeMEB6AfYbOcvjFGw4lNJjm/j/nhq/B+iIKToI/stYaRBaJIEjPhpuqGaNonNtGQwCl+vs1QPT2MLM1w8fR9kkoBV7F55rI9CEH8+fCu1dqZL/W++ldRRpkvGugOjzRrbf2E3ynNrVr/LsHetq6zvbWdZYpWBaipe2QZ4qcEyS/ngxKECg76TM0a13dG4NwsjmJkgtmTBty8F+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1593u5AIYrFrvsFXXbhd+TIFTZXEgrgaQ8p+Db3PPk=;
 b=X+cvgG9bOCdbPRfththGgh8NcjGE5oa/GbPsUpNOMRJrvXn2M3f7l5XCtEAOnNmvX/wGJMDCjFgDLaQS0s5CrwuPR7GlbJUbbGPqeX5j3aqU/DMlZbSTecLiHsYrezLO4SpZ3WbCYPbv7sZfXvLJGsZUX49jMymRSEyovI4KdukcI76c5GG8xpteCHq88BlPtfRjHPzsbG1Ml8fj3AfPUKXx1M2wOyqEcHMeBZM7udeE4ZhIrcx2NS0hrHycDqNH+LPqDRCJKaSGkV49OOQ9elRuVlpRh/QmHgluSTnOwNaiAuBr5+iTLXwIAoQXdaVYSylBD9bR+hyfpGOdnpPy2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:33:00 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:33:00 +0000
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
Subject: [PATCH 08/12] mm/khugepaged: Remove redundant pmd_devmap() check
Date: Thu, 29 May 2025 16:32:09 +1000
Message-ID: <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::8) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b0d104-b574-4bfb-7435-08dd9e7aa7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4wyMt4zOfVYFh7J1j/3W0doeAtt+454MR1gtziyXNTc0D1kx9TXNOm+Uvj6x?=
 =?us-ascii?Q?Tgs7y4CPaX23+nr0yngzswwgAXg6/zBYi+4bBw9zuGfbeNs/dkisyFqbFa+Q?=
 =?us-ascii?Q?PjKD8fUBnUDyvXxVerYg2mnA7qWCXNhVMYRLie4ll5vw+rd3w8hLY8AAQkCh?=
 =?us-ascii?Q?V4BmPxdX00M7JC0zsfHadQfFvWbKcJFV3lLsyOR+gWO1hkpHJ9Tl8wopRNNL?=
 =?us-ascii?Q?IdDgYoGsllGiSdmrUcJYgn6K+MwOtNGBOCArPO74Tb9RFw3Cct8dfOxrD/th?=
 =?us-ascii?Q?sESChQyHgrEgwPeuEoAGk+ZO7MKd8JS1q120vOmjsfP5vh1VBE6AIro2KVJp?=
 =?us-ascii?Q?FvQNimXU9HAs4IWBl2ux7mknu+xWEHD+xWEjM/jd3rzjvWJIqqgrtK2rG0IH?=
 =?us-ascii?Q?5d0J2c9h5ziGp+MNic8ckhGKlrRZzETmjYTfRBWsp1ctHrpGYQM3JziwDBYW?=
 =?us-ascii?Q?cjfBTcjL45aYmNg2ZLV5CsQfVZpqcPurR05k7CUt8jFav2vNeREn8emhzsTO?=
 =?us-ascii?Q?TjhNTcaTIJF+4f8+uazOprsg9rszIxJImcBVS8xrJPWvQEqCDD5ufKxUyNYb?=
 =?us-ascii?Q?OxfRcRNgZ/X0snmWAAjBJWrCOMW6+Fci+IQyTXuLYu1zZbMGYz6LeZ+vhSu9?=
 =?us-ascii?Q?28aZerFTPxiLlQk3bP+js7hDSkUGYoM+CZnkNcWavJsA4CogwbnJtbjqP8LC?=
 =?us-ascii?Q?wqOwPmHIMBsWn5CEOxHhPbBgslnKNCQTjmFH+8hY1RXoBdE+mRzS+NST1Y/A?=
 =?us-ascii?Q?CtI8ZQFdoRUZKm/MG444zbRMgq4OzQFqx+oGrEgdeM+LgtCxCVcqnCWQuydi?=
 =?us-ascii?Q?ry/25IWUSl1jsJ5K/6jCi4j3CSlYpGP9+4/8FNbw0ayvXhUxHKtmOWwEp6uT?=
 =?us-ascii?Q?1L5iwoxL0zj0pTjGMt4DLKS1aQ/UFTVb/CVy3Fm+LM7GKamrOiqfg9QVCM7I?=
 =?us-ascii?Q?KviflH46FoOaFVxL1e+p9OmXQCK9lKNj52XzmCOc8EeFHpg637GjhVbrNGur?=
 =?us-ascii?Q?mGKKFP8Byn10w2oo1Q0MtIEF7PD13yZ3H28MzIAlT7p+Oo7x5+H8mYRTNP21?=
 =?us-ascii?Q?BZ9FpVTMI9LpHjtqPzGVP+OcZXj03ljWTgFotEc+I8KnSnlsKBCRcwKFIlQU?=
 =?us-ascii?Q?oEOLpZT4TFbkfSO5pVM4RJ82ZbtTjGZuBtMvKVihT6yadr657ftVncdKkZq9?=
 =?us-ascii?Q?uD8Ki0iFUiynn1cyuVMXtdRY8p5Fl/npAMX9LZtqQICQdMAdFg6HOcey5wa1?=
 =?us-ascii?Q?qFDhbUsMadT+MAQIEuAtwv5gbiKnrvNLU9GsCyRkS4MUd9CUEeeDQ8CCjo4J?=
 =?us-ascii?Q?WmnqU+P1W3bEOPpg0OBpmfppMTRqwvH3NYU03AXyZGNG9wmNr38HSlmGzXwD?=
 =?us-ascii?Q?aD2cfJLDA/Ja9LuwcvCM3NadTj7Om1VftEuJMeX+BJOuH3fQl5YiiY1m8vru?=
 =?us-ascii?Q?JOrFzGFDwjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GC72EeePNt+7A/ye3+/mB96NT0PlkvzFCt9bbIas08pySrqHl6Gw7kv3lxlz?=
 =?us-ascii?Q?v/PMTrEV+0efgPVijdwiKGvrs5HunJjanWIB1rIyx9Czlyq1mUBh2Z0hC3vb?=
 =?us-ascii?Q?eLfEhns9Tgzz5VY+VLjAvcQBAHU8XrjAVH8VSdHZr60HXHX0UD+jGSkMhPk3?=
 =?us-ascii?Q?wen0MJgHyQnSkSKyOsBX+LE+6azhXaiMCe/TdVkl5vFFkmS0kPwYuCFvhstg?=
 =?us-ascii?Q?nmDKmHaDg2fBz27Lev8jbE5HmTVAjBMf0kathFr7X4bE3HORoviKSSVoDvK/?=
 =?us-ascii?Q?CORyhm734SxVG7sfPlR7X/MnNLqKLtn7+9Zmb834RjdJ1eG3BgqeRH2gKRbr?=
 =?us-ascii?Q?wWjSXF69NOOzaIKD6xcUAw8hXUZfrqKowtoeNGYhCt4iQgn+gJGsXdXclqBC?=
 =?us-ascii?Q?0Pp1S/mAyvQHzzlcHl+gnoG15d16Dlt3COz0ft9qbGUunySjX4iVz2TroFT2?=
 =?us-ascii?Q?HnqdscaQ3oiupzdsY018hqlQhpdq3q+8xn5NqQn8Am8SvGCMRJfLsAlh+uvy?=
 =?us-ascii?Q?Ti8s/wI0ViG85ERvTCIVeX2p/oEauyKOV9k6sZTKWZtQnjkf3B2o4s3Lonku?=
 =?us-ascii?Q?dhi9L514//xNHzEwJ+brlaHO2ydXtjdJL1BhOk34W6SZhFLarUdZvT/yMsA/?=
 =?us-ascii?Q?F+5VrIA6556IsPlRA26ENzklsxR6Y32jbqc07FU1DY8igqk5A/glUGGg1Umo?=
 =?us-ascii?Q?sUDs0jjlwER0JIhikqKH0wwdDD/2J1mS3mWYMxzXgXiRyFy6LfrzkgDqArSu?=
 =?us-ascii?Q?P07U7lPtKmfQDHxZ5LUOwGTHnLQPUHpgRse4MI5g1JpAjQW6L3mrS856lS1h?=
 =?us-ascii?Q?nyKUlSHWZkCPnwz2qtVlDzhlDekwADaAWanTPLulwK7NVF7YGcv5GRTK6eVz?=
 =?us-ascii?Q?vDu/Dy+nJm6f7SITB4dnLyQoxyOGKqjQaNiutMXFI5BIpfJyE1VaiHrs/dsR?=
 =?us-ascii?Q?2se1Vo8QR85yGgLbs0RnyZsnxTpTJu2GShohwNjn9NJDTtJ1b17YAYKiwvh+?=
 =?us-ascii?Q?Ec9PvaWJBfcvqTOq6vkMFRPkFI4mSux3kZYIoxAb/mYtusJQpYD4e775h1+o?=
 =?us-ascii?Q?KNsWt5zSk9BCdxoA7/BDti6Ojs66HETDXnjfvg1rfUAJJjzsmmVgW3Fq6rlp?=
 =?us-ascii?Q?jUuzuWgHo4kZJwuLm2SvzlMQd2jOWzKL3kYxk85Wk0DSBKFPAfYlgtrCDoCO?=
 =?us-ascii?Q?nxvUf2o/2ggXZ9Zj12iyrWmxKxSWpFhzk3TlSSUOkf8CmxI8OY/+uJSkJ/kE?=
 =?us-ascii?Q?igEzH53w9R/23kKSCXpIS7UWufPhl+XrVqK7fa55OJwYmjzDhcnj1wUmw36Y?=
 =?us-ascii?Q?yyp+ywKySpI+AwMXNGGkXkeXKAIYIfmXQdqh2rZnUb6mrNIbgik/ypPtnhez?=
 =?us-ascii?Q?OLb/WnOpaeZI1u/VKwrGU3Nl7d8WrGkh1ZQydJUGFCRlDIYdwG6SINT5LelC?=
 =?us-ascii?Q?V0+pzUR16S+kT9fs9fKGhIYhg+4TWcgwUDNXsyxr2l/IDYrjuq1TDoMtnjtk?=
 =?us-ascii?Q?nJ0eA0reFCFQ4txJVoPRyUKGzOHFph2wRcMl94ZiEMAHgSsXz3l1D0VFg04d?=
 =?us-ascii?Q?/DyiVQFd8J7oj/DCRdcc5mRbmU5ArYwp4ghbLQkQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b0d104-b574-4bfb-7435-08dd9e7aa7fb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:32:59.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AJkiPqIB3m5B47U5J+OdMTLQvwd7ZhcY7EzUi2spnH365anj+/RK8ar8T7SjZfYT1paOABDQ0uMo5/xhugEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

The only users of pmd_devmap were device dax and fs dax. The check for
pmd_devmap() in check_pmd_state() is therefore redundant as callers
explicitly check for is_zone_device_page(), so this check can be dropped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/khugepaged.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc945c6..7c2b9bc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -958,8 +958,6 @@ static inline int check_pmd_state(pmd_t *pmd)
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (pmd_devmap(pmde))
-		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
-- 
git-series 0.9.1

