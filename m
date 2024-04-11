Return-Path: <linux-fsdevel+bounces-16633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B08A0500
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B329B22640
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813ADDC4;
	Thu, 11 Apr 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nwh0b5EO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2117.outbound.protection.outlook.com [40.107.223.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CBD530;
	Thu, 11 Apr 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797075; cv=fail; b=DIhatBhtCVKGwHiGrYH1ZML3cz2tWaKBhZXsoKL8pazt9iYKpcolFtxFnubltlX5LgJXB74Q38XC29eVQKhH5RXqAJ1hrjnV+ctNmzK1HUxGdPWPwGuYF15LHTvecUuZj5YeZ27XARyOEptX+7f30Y1xekEnhjupUMBM9C/YC+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797075; c=relaxed/simple;
	bh=HLFPdxc6j4QAD95WThmGwMdDJsWTkC/cuXw9qnOPr04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6eTZx/EA7sx59fN9Sbtb45xRKsPtsCykJZ+tka+Tt5Tfj1DWScgGDH2loeT1pBjrjhwvJ1wfrahm298mWhCOrViyxl8ZuK7GfnW/nxr1Yi9qjuzuGR+HHwQhjXyunR8Ra2zMDM2DkXhRKzb/fr3moJ/pR0vNS1MHNgMadi4VWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nwh0b5EO; arc=fail smtp.client-ip=40.107.223.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnRJXF5KPJEYWFzsuANTSEwcySPGUo8RIBy50PJwJcA5qkHrCOG41/XLqv6iZbDWeAad6NgK84E8HaLdxxkYwjUk3QfLQWaiNJvStiqQJCVHf8c6Rghf3dVa1dt9mt/c0RZR5Z8uqoFXm4m7T/rLrZebk5UMLyvBeVBLDuFWk6wHsDpkvW4IQmEXSX64CO2H5CiJ4o/unSbd/VLqU2glHt+1Ho5KDWapy2tvTPKnA29/zcPWVrCmX8wnb0VlEZWxANnrDdEKaa4e9Q8eStqyQSqYCqgVHMmwVciC1RzDy9PUsYs99nAwyv9NWlybi5JKIIcisszOlrHcDXwklqbssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDgTssP8CMRZtuU21cL48WhQnx+2efw+x/hmbV5B/xA=;
 b=mI24J8g5mr8WZPr0iPGDa1CxDvCB2HM5rDqXpBXAe1amZUg5q00f7ityfGrLMDecnheTqIUDnQeeV0CoNuMDdq67Y10PD9Zkj82v81lWrYI2MTa7aOOsjTB6zoEZVKfRZnS81QiVscVHwo994SGz06DX78KbOiHhevYKP1TbZrZ0WADMxCTsLXMK8VTVPzV3l4CXDVahyDflg4S801zr6xlJSBLaEBtYUtKdxH856+p38WfKfr7dtjyoPZlaMpnkU3l3dQtktKN/YFereqRhmV7tEY4p3bmmmuZe9LmIXRNtjKpfB4hdDy7q4cDrajLhwO88DwQynttMhC02Q/06mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDgTssP8CMRZtuU21cL48WhQnx+2efw+x/hmbV5B/xA=;
 b=Nwh0b5EOnt+2EtpNHM57C3RaTig+we7bLBVuLfrARgj1rXmbZrhrJ1TkcVWDHh/ABAJVddlqBUnsTMwALVBtyF87M+Y3PSYOly5ZD9FhivDFdrkdCDgvwwn9InEDq/n71/KxtVtMdR4LKg+HFb8bEDCm9pJ/PhGmIhgRrlHp60f+mIr9KLcyMvpbFutKLX4tWIBuVQfy1/K7L9k/y9gkqagogmltgp1ODfD8fMxXeYGD322+VcoHTr4wYiNu0cf1dbpUqPIan5+K77TR1Akf5cgYKSy98okVfBAwOdiWIZEKJPAWY2T1ktcnCJAi5qqq1QC8pajAc2zftNU07cXYgw==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:57:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:57:50 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: david@fromorbit.com,
	dan.j.williams@intel.com,
	jhubbard@nvidia.com,
	rcampbell@nvidia.com,
	willy@infradead.org,
	jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	hch@lst.de,
	david@redhat.com,
	ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jglisse@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [RFC 02/10] mm/hmm: Remove dead check for HugeTLB and FS DAX
Date: Thu, 11 Apr 2024 10:57:23 +1000
Message-ID: <e4a877d1f77d778a2e820b9df66f6b7422bf2276.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0111.ausprd01.prod.outlook.com
 (2603:10c6:10:1::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6bRh6iSBy8FOmWJlxc2tuymRIIs1QTSn56LoaeCy5iQKaBh3RyhMSvFbZLBjlVXt0JMp3yTDeCXz4ZUflv9ZrE95Lgrxp8vqu6m/cuZ8JX6e09uNVlHBv7nJyEbwpiK4DkFDgnlKReNX2dNVlatNT6vi6s83pU0T4DJpr0ximqo7RrrN5abb5OvAJ1RAWNThrmd0FrtnPMcNdtGrpykmWjy3aEmRZGVni7dNI7C1rgMH/fVECf6HHPnjCaaucT4dSGDWghx6tPr/XP1pc/Ts+0LRwnTr86sEnMYXsnYpiKpnjUcX4ehrkJy2MDJ0070gmwzYA1HMMJ/7NPRSUyWmaRdsB65XoomFdYKevgkqcBg/PgJGBDraCXI9ydAdURO4yKIJwDqSc7hMxAZ01eNWP3VO6diGeSgbCEHOUo7+NSnTKTGAz79CZl5kJ0Q/c9xR+KoSd4xp4Nux/uN8sweSHtdU/onyPsJEH2IE4+7lDibuU7Tnp4Ivq0zCeMBFESktovnCAM5rwS70bmJBxFwhmpqRjGXh3gIMB0FRIzZ79Of/EGIL4ByABJdfP9+5kiBOxdGwSdGi2FjpQ2FLgRWBdkJ+OzG/+rPrukMUaK3lVUqtwYTEOKEf2Gkw0KQE0y6tA0JS9gQ1tsyk+KX/vAjiH9ps084WSMlEzJT8oUKGrLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viyIx6M2PMQ9wbwjuKnYj2Jvhc9sgdX+u8ZVE4l7nbgScx1RmHAInqQK6kaa?=
 =?us-ascii?Q?9dsjjvOrjigrs/R+Es/iTSvsZXY1zKWsWy9cC1LWsx2imuSucjzKuapZskp7?=
 =?us-ascii?Q?z8m1GvghBSQzALg5WvcSEHdNyPystT2NPHFN7SH7Ssuk3gNH/FZmlAYoK1cN?=
 =?us-ascii?Q?RC7SNiS9w2/ZOGRsVFv9KCIZmgpC8lozQ6ZgyZqcRo+O+51kPCdgCNJA8VUs?=
 =?us-ascii?Q?AFOmw+rfHUNgeZJIADYu+ebGc/aQUmcblsAPJ77XCp8vfN4Wdxbaxk5vKpBL?=
 =?us-ascii?Q?GHopU6ufgttyqLPbnlaixtynN4D9pfNZnBCzHYH9Wkx65DcuIgD5f6vu2TJD?=
 =?us-ascii?Q?xexwlyVo7RaaJP+BIdulDLd/jKjBHoC4qORk81iaWq0Os2WQpTvJCvCHYWtv?=
 =?us-ascii?Q?nX98tSv1469Pld03T49yY91iIHFEi8M2GfO+9xe/14FgsZSYygboI5+s/XkA?=
 =?us-ascii?Q?4eibhJ4lfJ54uAF7nD6VnMarkm/yadDwkbRSeZg/q0TDFJwfidjZVGQ3dnqm?=
 =?us-ascii?Q?2Dk4RkmCoMuj1AU5C0fuu2hIa5rYeatxKqaW9xBBpvcj9tda9+uOiHess3u1?=
 =?us-ascii?Q?UFl1alhN8IQ75DPVfEAiZAQuBKM2Cd2zUS1TjBTGvVeOLJqWIyc5UWntEdVa?=
 =?us-ascii?Q?ByKmlT/5AT5PZJPyigrS2EbFdWiz7Tka16SJBZIrsGezLTju+ZUIfvksDQgS?=
 =?us-ascii?Q?Ov2uUhYeF0cqjAZBYE2B2sq21Sm/mPvnqQdMnvpQOxZ635kLgeUqnY7ng1QP?=
 =?us-ascii?Q?8gOhjfhFlw/GYtZi5kxujPBJH0MzjTTlEqEhUvfjm/4py4Z6QfECIucOIp62?=
 =?us-ascii?Q?a9unzChLj8e6FEjbCEeUULDZFQeLgdXCYUbDOSQmewOJbf291JMlQ4XKyLHs?=
 =?us-ascii?Q?b9Fe/p6+L/MjTFLc5O+kPBm7G4ZsWjhCgSMVgVTKiRXp7OVIcVYeZxBoHvqC?=
 =?us-ascii?Q?HPvOxrYzH73bfj4s7BLIJBIE4fvVHpzHJSNfGr/CzSIBoP2ggqFSsYyP5UVN?=
 =?us-ascii?Q?SRaBiMtS63iScVJpfBRxa1EXHi8uhVdxSKcBGTm1dw/JGH8Q/mdnZHmVgoK9?=
 =?us-ascii?Q?btctRJsrGRMx2rAGbvi6Yg9P08OH0W8sIYql8usRH7Xojv9Ut7hq1+AQ5Mzg?=
 =?us-ascii?Q?mf6+CgXIfcI7XzFhhyw31ran8Uhb4hwCTBqTDefvi3cZ5b8I9Y8xC8ZeqDIl?=
 =?us-ascii?Q?O0jQenS9BWcC4QAiyIGkqO+N45d8fScli0ZzVhkOSNqJrHnYDjz/tjRiy6Mb?=
 =?us-ascii?Q?Xddq3aVsc49Xo3w1LKDP4Pti0/6pNBf+eR73SCTvsuCR2OkbOBRtj0bIHNqn?=
 =?us-ascii?Q?yfISn6phahzJzaC2UnmfIQeO4qbQMbwvn2L/aJ9PP15piA2WA0C+kWrVTVjd?=
 =?us-ascii?Q?tpMloF+GfOgVSHAbzHisWseFc0RXznpgtWguPdpawhKgWMg07FCH7RvxCHkX?=
 =?us-ascii?Q?Jesx9BA6MoKtOJrDZWew9LNVU9P0KykkOpgu4Zk/9Jps8nz+d5GqOPjohy7n?=
 =?us-ascii?Q?tSzS8Q4mQExHznatKogPbMUKtbI3gm0Y+Fb7wTMeo87EPZUfyE3SjfT6Tyvx?=
 =?us-ascii?Q?gSAILCdrYRg4DQUlEm07roCYtIMXbDuq4b2EBQS5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643891b4-705d-4999-1a10-08dc59c2697a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:57:50.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bECjJ5cJJ2K5kivc22b/MqxFC0xpTD0DJZnclo5mXIVnGTJbYoVqY3m7jaKBdTLla42PGNHgs5FOAMXSsJIjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

pud_huge() returns true only for a HugeTLB page. pud_devmap() is only
used by FS DAX pages. These two things are mutually exclusive so this
code is dead code and can be removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/hmm.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 277ddca..5bbfb0e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -411,9 +411,6 @@ static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
 static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		struct mm_walk *walk)
 {
-	struct hmm_vma_walk *hmm_vma_walk = walk->private;
-	struct hmm_range *range = hmm_vma_walk->range;
-	unsigned long addr = start;
 	pud_t pud;
 	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
 
@@ -429,39 +426,9 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_huge(pud) && pud_devmap(pud)) {
-		unsigned long i, npages, pfn;
-		unsigned int required_fault;
-		unsigned long *hmm_pfns;
-		unsigned long cpu_flags;
-
-		if (!pud_present(pud)) {
-			spin_unlock(ptl);
-			return hmm_vma_walk_hole(start, end, -1, walk);
-		}
-
-		i = (addr - range->start) >> PAGE_SHIFT;
-		npages = (end - addr) >> PAGE_SHIFT;
-		hmm_pfns = &range->hmm_pfns[i];
-
-		cpu_flags = pud_to_hmm_pfn_flags(range, pud);
-		required_fault = hmm_range_need_fault(hmm_vma_walk, hmm_pfns,
-						      npages, cpu_flags);
-		if (required_fault) {
-			spin_unlock(ptl);
-			return hmm_vma_fault(addr, end, required_fault, walk);
-		}
-
-		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-		for (i = 0; i < npages; ++i, ++pfn)
-			hmm_pfns[i] = pfn | cpu_flags;
-		goto out_unlock;
-	}
-
 	/* Ask for the PUD to be split */
 	walk->action = ACTION_SUBTREE;
 
-out_unlock:
 	spin_unlock(ptl);
 	return 0;
 }
-- 
git-series 0.9.1

