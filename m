Return-Path: <linux-fsdevel+bounces-38825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF6A087CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3293AA120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAC820D4F0;
	Fri, 10 Jan 2025 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UgLDriv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE707207E15;
	Fri, 10 Jan 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488982; cv=fail; b=VklczRjOU+H9iLhE0BvmpEogO8nZhw5/sPZzSz99uYd013Qursbvsydjsr1R7loIM0dZuSBg9aDAQvCenBPBcrPA7B6yaJMOlOSmPv/kJlAULHR9YWwP0wqfgruIlMm+fINjWPIhUBYo6qAFAchubVcDCSvf23mFlNtRRwHuPf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488982; c=relaxed/simple;
	bh=ENb6SZxQecnoaFbHfwgRGbaSbQxHOqcV89BxHel02z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgEjG7rm4v2BCVQ4g26/xfSmkHroNP6+sl+2O5pS9jW7SUP2ZksvXo53Cc8jBMpCJ1Fh1w46IAliNdPsg8uKuQXuKjRHkbETw5lHl8DBsXWmUf+4Svp2IxxyhiwOo/myg9P3uX6OgYYmMdOkpupaAvAfkMujbOqHQ7D3ehtMO2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UgLDriv9; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os0j4QQ9AVHD3pIManHjassG3FqG0GNCb/Ku8DlBVKUexQi8eYH2PuIYRsqauR7xJVKywVoXRPEVMN5JRNer3jHzbcFhCDOymkK4BtTPHAyuCMNnYWOKCtmqZ2UwjxhNkFMRLg4iyc/NmxL49KGZciWDfaIds8yKwqnS703v2igc6xcSWH0jErLF6TGCRyzmdrubdDj96IyB/5LvTSfaDYwrE5x8xX+E61xbuR+CpC0EdaWE9HdaF7aYb8jpeUiZrpi7Os2/I2uP1UgzKU8iKuLpFqCF9NGrmPUMoOlD2Www1drmYwPewFivmJQnXpSnaVXt95XXgPYkgEJPe7j9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvFcZCSCKcpqUQ54gxypRLCdDBXUc+Lz/TVUpjcAZiQ=;
 b=Tl9dUe6S6Veh3DXb4l0UrA985PTlyK5ieSH7ltckscoeFl+9i09ev6qYVZ1dS2o9GtUyGT0/4nDe/5ujSPmH3tIOqWBPWNtNzNiqZ0Cx20JMpn/+0bt7mkC+mY11+cILbXR0yZC25pVz9+//WHo9kEFZpTtiMddYc1TKiPrA0EPT/vJO2Qi9N82mSMOaXPH0cE6uDMFOEe4at25AzTxiWZmsjyf2Ck0rXngBQ7hsI2ggPTHILcZrjGx1OFZJNpc8mdbYUIjED6SSwMeHCnqxpM6QJDpkTYzAFJJpO7b7VHmIWshX/hePYyfDfOg6sEcKFdo0RDeVUZyWBGEvSk0Klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvFcZCSCKcpqUQ54gxypRLCdDBXUc+Lz/TVUpjcAZiQ=;
 b=UgLDriv9nCvZ2Wi1DRqHranyCDqSB9FfjRiLaCzRCHdxNMAS+JGoLhYLRpU9Tzm5e2an205RRcYTX8aWF19FvH/R9/wdGyVGiu9niS4FNiJjcSYL2tmWzu/iGyqakwdbKdGqYg5ytGjbeeie7LqjJTM/bW2iGdODIqGJfZJjZMoa5wuiBiyldLTErYXA1uNYUWRGkRHnGFtgikzqcF7ru1euh0RcveMJCgedml/VkBMjV40WXz2uaLTC0aJMnKj2ZYgToCgIhTq2gDGglte41a3iYnHMXcllBugLbd4GlxLyhPk2FikAoIoKX7wx4Qauz5W4TNheYncleOodzzynUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:02:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:58 +0000
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
Subject: [PATCH v6 19/26] proc/task_mmu: Mark devdax and fsdax pages as always unpinned
Date: Fri, 10 Jan 2025 17:00:47 +1100
Message-ID: <d7a6c9822ddc945daaf4f9db34d3f2b1c0454447.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0022.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 456f7415-3a4c-4d56-0d10-08dd313c6f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJnuwXBuF/7HAFkP/p39Hn3UsYnbbfdowcFCWovW1DjPxy+Klq2M2WBYgHl+?=
 =?us-ascii?Q?Lv7TXkIwGBR2mQGE2JKuR/JyVMbPbHO2spguE50xpjNhfDkbdHAAp6Mb9mlL?=
 =?us-ascii?Q?8OflNeYdVkTNsIW3velfoLnxKV53MjeV/L0muz3LqtS0E2qNsJBqziY/b+ki?=
 =?us-ascii?Q?Yw1gP0ZHPdmHxZeoNoDrKeNGIBK3yJ+zNsbj8Vq1IkuWsd83r0ztYAGGIq97?=
 =?us-ascii?Q?W4j6kyN63e4Jeh3j5YZBEoqZMzRe0TavnSlfsJXf5koO5ua+w0zutlcjNQvh?=
 =?us-ascii?Q?rNSDvhaYp5YPd64J44wzY82CwHtda/jC8nKPRNVxd//n2KWdcMUh4xikUk8r?=
 =?us-ascii?Q?dmzt1ryLZ1sp5dI9VpJCXdySQ9+FY3jEgRNeaOi2E93LiQfsNMHqv9l571kg?=
 =?us-ascii?Q?04xsx1ZbpkK37Ql4utq22x2IexPWe39looKaPWHdeUgvy6kz1icXNvUWnAe1?=
 =?us-ascii?Q?Of+dfcEapxqL4dV60P1DCIEZdeABMVpMdgKWNY0l456N+UU0eHsxdMtVaGTF?=
 =?us-ascii?Q?uM3FrToE0j5z29GkDXQ8zPCngS6V6kpPDPALS9qo1oLZ+R5m5dBLPtfjMcl4?=
 =?us-ascii?Q?RrxubY2//ZTtvRC77sMOACRM70ffGGIRsQwhObdaMixrvovvE4rn3VpsjBrJ?=
 =?us-ascii?Q?njdxylsopy0RK9I3TGLky5trYGrXzcMYb3u9yM4LIn8KKDFq+72rS9OlgNds?=
 =?us-ascii?Q?KJYIbQ10RBWhTpzcl4iPayETXlZwJOa8tb4o078GN7j2DHltTaAxRMgj6kzJ?=
 =?us-ascii?Q?TYBxVIDGKpkFKl8C7yYUtpvytPCQkspHcTbZLrOa+JZioNP/HsfZZ8cAY/7R?=
 =?us-ascii?Q?CGHTLpdzAVhb0ZyD19jrexYwqVcoJl5ng93GTtlZ+gjC1HCY6HDljni19qcY?=
 =?us-ascii?Q?WidO27wk1WVRhUa5kaja9/dT5nrHFIItaLU8yV08h3du3NPMeCvgiN3ml0P4?=
 =?us-ascii?Q?y5t95ixgKsIJCpqq7cX8ENid8CX74buWf/cFatrdW7Yq3wv6/Q7goqFeMw5i?=
 =?us-ascii?Q?gycjz/VWFqcnmYUVpLtEkm014Jx+7UPliLOt766IrC5XOve/dsdh1McWqZIX?=
 =?us-ascii?Q?3Q8TMns2Wgk4zwpu1vjTOMeRA2D2O0UU0iFt8WvPJJ+rLgGbS1SRFkbJmmJc?=
 =?us-ascii?Q?zPW/u3uYuNCvbJRqMXUCIjy7cm/YczjmJSZhFXL8BRBFPJ/zgiCdzXnoeOUw?=
 =?us-ascii?Q?0LTut522AkULrE7Rbt6SFx6IAzi92glax+eJmVKH6lOxscflYgPsF3fROPT7?=
 =?us-ascii?Q?nliuNComm3tHLD/Uq8yPhN8VRh5kc/6N6JHklpY3IbOO8UEXvYiwbjxDOxHW?=
 =?us-ascii?Q?hI3Qmjlb7NXF4dms2YuvIJ+QrzEB6JrGrxKonqRQ4UEd/G6CrbdbD/gabCrS?=
 =?us-ascii?Q?HkOmd07aXn0D+oIel/L8ZOlBs4qy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/G5kQu/rWqQRdtzAGzszb69dvat5O+2SVsPRaiQcw/WTDICZZqGpBfMBL7EN?=
 =?us-ascii?Q?3UPrd5TJT89+lQtgZgAlGw/Z5fhDQvgugCKL+wPxZ3/CDFQqsEJMFHDwZq0m?=
 =?us-ascii?Q?kLbQ+STSxGv7cc59MpjW7qyZPNyjSjOECW+xlfG0SRWk5Ge17ePcOplJosZP?=
 =?us-ascii?Q?MBGwxF+EYhaW4vBgXRd684Rv105+i6fS3Yk8aPeyqwMw+WgPmJ2AefxWzgVG?=
 =?us-ascii?Q?ntEDVjH+raLP5Tt6z24pw/hKJhqogNU6QHwOJxG0KIcCRSr1dmsCF0VdFx5x?=
 =?us-ascii?Q?/I8yWNGvZ9rYspSHZLcYskqtKN+VT0dRSjhpbBxE+s2KfYXLRKwxedyn+adj?=
 =?us-ascii?Q?ZtopgO3n4FPFTlfqpGvGC9BDInbVFk18p3/fgNoqBkXVu3WwdPPi4gm+SUqR?=
 =?us-ascii?Q?0v8zcKSvlUuZIOlxYX90rtXJQTZ7dxPalz1kKMvX79rTthG9L/lTe8ULnpFB?=
 =?us-ascii?Q?e385Cu3mJVC/oi5DsB/Ux8FmswRSPMUhPC9qtMRmB18Ygdme9GhXTwlxVx0D?=
 =?us-ascii?Q?BGr10xOaVnS2Ssjgu05DHUbI3oFiDIwGOfCbs34U/wivGPohxEFD2yEIm4GM?=
 =?us-ascii?Q?rFdgBMqFm7sz9qSanhx+bUcR9VOL0/1TuQwLUeFLrPAQJAUPreCwoFcHqcha?=
 =?us-ascii?Q?SLp5/UzQYs3sxtOA3Sn/niG9ZOg1U7LpFu8WwACsC+d8omS8f8/WFHTtlik1?=
 =?us-ascii?Q?rQK1/lgdZH7q7p0LMEudlXvi5bb0CBxWmVWne/JAjLgNGFeh1LSRZGzIrw3U?=
 =?us-ascii?Q?b5PfExQQ8EMt4ZWPt6ZlJq+fHzcN1r+9IIhgxGk901uU8IxQdExxGqBur77o?=
 =?us-ascii?Q?SAYtFvujDPdTlkTxy9d4v/555cOGkpkEkJgvqPjw9r7CKhC3x4uHssonvADM?=
 =?us-ascii?Q?zF2XwPBbKJvcelz4TIYusxrnpExH3CJIUxwLQPHNUyPoneo/nDSOWanZ5hvR?=
 =?us-ascii?Q?jPUD2D1MEg0X0gUxJp96JK1KyHmi7ujjHlTwZvsrG3WFfz+qYiMVwZQB95X1?=
 =?us-ascii?Q?nMtO827mX95PG/qukxLg009x3NWY37ggkt1OMZP70IuywTUMrd5cmzU/8Lew?=
 =?us-ascii?Q?u8Siwkvu1dZGvxiZsx9Z0dX4BeDkKSJ4NbQN2+H5d12ueMEdbB0KLqKF2FXb?=
 =?us-ascii?Q?kCJaK7yTh5spVi4YkfzXnoMocrrt0fX9mHl7vN8pyRkqh9xUWEHrHxunQANG?=
 =?us-ascii?Q?zWe7aPDlurNsUQBdNN+q+0sxuJ5qn4cWCAEswrzv215P08+ASmKefvtXb3d7?=
 =?us-ascii?Q?RjWHFO/gefVkM9gKhsXDKd380Sg9pfgkOINCzX32J5srMkrrZU4aleXEFlK+?=
 =?us-ascii?Q?+4u6JvcoM5/xSv2ZpNcI6sH6X7fWClQK0+SmyjJ/qBR4JxRCF7IRfksC+Y4w?=
 =?us-ascii?Q?Vey3NlObJYC5f01xRySXFiKyxA3XftqkmAs9FoX5TAu87TJ5mE9AMA747gq+?=
 =?us-ascii?Q?VKPYPE4HbcpwIuri+M9bylu/1a9m7T+mohk3cm1jYLgvLld1fzUnQqH8lQE6?=
 =?us-ascii?Q?2ZuXNKHmZ4fOzuqyNb248ufA8MzYIBLUlaFEZvppAwVGFYw9fk+QE8b5mw5d?=
 =?us-ascii?Q?Ffu+U2QZHLORD3V2osX8hluB1MVdqmSkjxygGPoE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f7415-3a4c-4d56-0d10-08dd313c6f04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:58.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cno/dOo2jInqHkixqewlGVAKXyDUOLosISXpA12oyJUhC7N2j26/5YmjPX+S2IljlOzk5X1XxVZOJOQJf65rJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

The procfs mmu files such as smaps and pagemap currently ignore devdax and
fsdax pages because these pages are considered special. A future change
will start treating these as normal pages, meaning they can be exposed via
smaps and pagemap.

The only difference is that devdax and fsdax pages can never be pinned for
DMA via FOLL_LONGTERM, so add an explicit check in pte_is_pinned() to
reflect that.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:

 - After discussion with David remove the checks for DAX pages for
   smaps and pagemap walkers. This means DAX pages will now appear in
   those procfs files.
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 38a5a3e..9a8a7d3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1378,7 +1378,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
 		return false;
 	folio = vm_normal_folio(vma, addr, pte);
-	if (!folio)
+	if (!folio || folio_is_devdax(folio) || folio_is_fsdax(folio))
 		return false;
 	return folio_maybe_dma_pinned(folio);
 }
-- 
git-series 0.9.1

