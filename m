Return-Path: <linux-fsdevel+bounces-37596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527039F4292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592D1188836F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F9148FF0;
	Tue, 17 Dec 2024 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxrbt5la"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202D1F2360;
	Tue, 17 Dec 2024 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412536; cv=fail; b=hHQBDFi7aSqC0ysAj38PgOsQP4yLabd3hQFdaBe21elLQgXCUoENYPcDcLdUX7faOgmI7zPu3m5gsX3HzHXyGuI9VXHk/7frswGBt1M47KXh6NoGeeOY+Ou2/41k31YLGXPO2f9UBKXQ7w5QYx9NoTEpieWPI18pM9CQN40jD44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412536; c=relaxed/simple;
	bh=bVzgWyQa4w+3Tu64z6XFGDevakKWyWcLsWA7cirN12I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZjB6p5Vye+/uYx9t3JhwJgW+EtHdZkz5YUPIjXOGm4+4nteo0Sb+SPMJ3V8JdWQDn8nGKScJGBvdKzDf37MDV/R//vzl72GKdpdMXw/Rm3CQGjWEXfwF8zJc9y92omgWpb/3Z4NQMNwa3ciyTIgB85js6j00UwfsTjXjCR0FwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pxrbt5la; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF57srFH519e7P7RO2dcihHdh2eL/xzvm+2xqN3hIX3cH0nq4qIA2t36hnjBJRCN5sDJbcX9qdW9d/L8+Pfm3hz96U4wtE4/ZL/IIr8JY1f+or2vsIhiRJXgAmWh05fBt3TlYpexGnk2+5E8kmnqhZ5bA78Zs+eTthMWxVlw5keq02O9p5v6Y8aq+95pgGQ3MgXYkwx3xkNdx/SzrEcupPPREwPw/ZDp//ZByI/zM32TrSqLydRhHSWTygGKWi1PKS/d6RLXXPUB26olk79bE1dHdAHYTFnXnRZfY588Dglg2Wswtm0fx2WBLs9np1jGocOpRCPB6gBOHRZCsl8XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=opXrj7SbXd/MoF4o2gSLxss0S9/bWUkozbovykOXmWCzVBUeW7O35zUjU03tBV1/0UkKbSVxDZq6ndXiHakx8j8yNcwZZbZtj5gx1C8UjUagMshsJR/6SRH0nAaN/kvWj/UEmZ5ScrmjA5kwoQnLcgPI8qfiaXZLNagHJt7T0tkD9y6gtBcOWlbhXwp6khfEY4SB+02M2fQG0vRlDZ8eJdNAxbx2zo5Bl9wtXA7h0k3HL+Zgk7iRLmNRPxW8TqAn8IfFTplpGfpM0+c7vV2ZdfYYdcI5OA3p/lcQgcjSaEXt0vwbHE312ha8mTJ5IknbvLQF8cTZ8KxWKELbXGJ6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=pxrbt5laaiD4HOnHxQi8mKJNCZkAbiIdFKK/H7B9luGn+IDh+k2ZqzwNLevYX+lvqw6fqVlutYdjLqi5PFVubkLT8sGBD128pHtQ9ZOC3Vq5qM8hENP3FgAj2CLS9eDLuN7RqZUOH1aSsBrOr9pce4XqWRkR6Wmhe48DtNtyI2orqWv+nohYbaT06upxujl/xBIKPd04l+Ri7PRAEH6wEfEvJCeVozqNa2+JeNBgmd9uqP8wTpd5eY7RTHX3oX/DDZ+lprEFnpsu0x+556oMTRcbpqizlu0gtU9xY6m0A7dUXxKSWuQvKnABOYIDMbzvP/zFt/UuC9trHUoIlHYpvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 05:15:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:15:32 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH v4 22/25] device/dax: Properly refcount device dax pages when mapping
Date: Tue, 17 Dec 2024 16:13:05 +1100
Message-ID: <af81ab79fdf2e18abdee6bc0a5ab5948f388247e.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0022.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: f81d557f-2c0f-49ee-8a3e-08dd1e59d483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zq3vf2bInKE36eN0X/iCid4SIT2hITWwMoWuLPtxLWILIM04N4dIfrSPcDS1?=
 =?us-ascii?Q?14GHgBtpICnF8GNjXjt2yrxg4Ak2UR0t2bH95wLGtBCRw0I8Y8DuTgddQJOm?=
 =?us-ascii?Q?FiYLK/uWtQUaAIgAyFFy1h1WCgmFQB2YcJnEv2pHuZuPv6UDiuiP70cFzYU7?=
 =?us-ascii?Q?gpFUrGz1mgPtCuz/T6EPp7M3F+TpYevd1iedH94Au+WHscuN8JjANO5LERDF?=
 =?us-ascii?Q?AUItBFHBImYF5Ow8hmbEASnNfDX7sfnu/l/PoluvHIN73UUMiFa72VWBdKsU?=
 =?us-ascii?Q?W8SSG63KoU6jXmxNxr7FKZJ+bGB5DKTC8yTlqSy/vzdBlpVprRJaFFHIKvR9?=
 =?us-ascii?Q?mKO3EdVzRne3RG5fmGyMvsvMx5oSfBWgTBFWaK13xp9dLXIwyNF1ZaXAMu/A?=
 =?us-ascii?Q?6ZgEGWcX53XJWUcPU2JeLTlyhlX/bbjQ/NeqS/52oQboN4Ew14zUpcDbzU5t?=
 =?us-ascii?Q?huRhYyhSkwqejVjY3Tixi0zyNL1Sg/Oyw+vXgq9Xo7UUVXhaU9LPwngukuCt?=
 =?us-ascii?Q?GGhSgd6YRTBeM424CIozjCewMu5T9Egn1+DCNTK7RrU4fXaYdGZd8M1rsyT2?=
 =?us-ascii?Q?SFKv6+LJOh7RZBsqVOSygv1MvkNSlKTne9eCkAnacdKnyvbtS8xk6mQ6vMRs?=
 =?us-ascii?Q?AvHzx9URPAhWTQvQkbaESV6LKov7B9Ju26CCNoUqq5Mtgp+fUvxTsFj+QbPL?=
 =?us-ascii?Q?jBzYGGg19r2MXbLwX7e4dhWE8x+RtS2kvlSNL5pvP96dwoWk/5rfw/7mheo2?=
 =?us-ascii?Q?LytN2guuBQRZhrDICvOSq8gQPYEqDqyhpcz0cFXP8J8XsgFX0qmDt8LDWTzW?=
 =?us-ascii?Q?Mj/jC+W6O0PLoToCwnaZOxYXWxeIJPzVCOLaaRkY7TSoJwGQ7ptApt02ma99?=
 =?us-ascii?Q?5fSnNzZSV6U6WZj+DnqUprFIA3080TxwrqHlCtNT1/FJW+dP4F1XgTEVOY+y?=
 =?us-ascii?Q?xtuIbr9ImKZAjvZspBB7nXTS+tMqb8dTMIwR9uZfrrIQ2R/u0dD2B5witZW2?=
 =?us-ascii?Q?IQybBD//2Gm3FKYCkeIAnOzvKYvaTnj0Tz/65abpz/4PQ83YrY4hoOaprcvN?=
 =?us-ascii?Q?bLE5Gh2nALzCBofkicl62zGeCOGy+t2fsAvQDI042bA4JxYm/em89/m67w7u?=
 =?us-ascii?Q?lrXXaWccBFYwqmXCxrisVTbBO0t6+LsPK7n3TuotuZ1dFf3VJRAgBZBzKn5Z?=
 =?us-ascii?Q?Hw+Mi6ca+bAeOCwIIQn/enZa2Z/DLl1wk2q61kuyfBTKMlGQAWoZMbq8zJKr?=
 =?us-ascii?Q?rezMLIEn6IKd2SOMH9G2yoJBsxO7ytCKnHjm/gk+xAQVSkgcQLtoiKgMfgcr?=
 =?us-ascii?Q?be42V0wUCv3RDkOXoa0DJ6uYOIyqbkXhV6mHGF6MzxkBIH1XsEQJpvWFYMOB?=
 =?us-ascii?Q?waWBrFTZSp/DobPJ+ysk2ndSOjJo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LX9GV4FQNB08hEnE728R9r9FmMdM5tA6IFDivr6aQnrqZOv2BlQTjou++q04?=
 =?us-ascii?Q?hEukp98hy9JM1cy/oZVMdEqs1IRVSTx8X0+KCcDZg/Qhbm7E2quiSgzm7msr?=
 =?us-ascii?Q?j8jysi0Da2ZW45EGT+e0lO+deE0siNAWstXPgkHuQfTEs7mM7oJEws1xX6Pr?=
 =?us-ascii?Q?6+IiLTIILMSi1PpanneiobfKWtWOmz9JbpWtoU7p/tUH8S5w9IQ/30KvtQqY?=
 =?us-ascii?Q?maNcSFFesf5Yu6ScyX/5wGES4PInCiAkzqYLEATfuBhpvKIZMCSQIeXNOSBT?=
 =?us-ascii?Q?t2lL8b7Nyj2lYlCkzNDhrpL+hiqn5+/rqFu8wCIIOoHEEoD4nyPqk1t4hvfC?=
 =?us-ascii?Q?PoxywpKHlPxC4OBFDOBgpWrVaQEpx4oCLYyFBLAueLTUHDNDLDrPKqABQocu?=
 =?us-ascii?Q?wZDit6YADNKRfNhJH7aaT8MvqQfl+yWHUd7rMILy2j+7dK6jTM5LFkErJaES?=
 =?us-ascii?Q?164oPoF7TdBiHvQPziLRAziX/zhIq25mh+O4ThR08Ei05ybGFdTyrcnMLt//?=
 =?us-ascii?Q?NUiZTJkcwoXrLc1AJbnlAZBKl09VVQxsOCI1wZZcGTOfGEegES0SP2Bq0NBw?=
 =?us-ascii?Q?5CthwOKIAiAkqdDI6nyHqEd0zJ94ummroixGS/7hvWVrVUYasDw0rBg1gIWF?=
 =?us-ascii?Q?vYNvWdZ3JD13db05iB+GgGluZvM32ymn2D7DiLkGoTUDlEOtCil7zy1xRHFP?=
 =?us-ascii?Q?QCQQGzDVtBO5TIPdHBoMWoSzEfv0Nx2Zwj0AzTRCAfPxxY6HrWAgbfodNV7y?=
 =?us-ascii?Q?NVzv7HVl/KcRKqruEYrV4EE9eHPNHz3PxYyB8DJ12kWm9g3LXC0fLiriVk4M?=
 =?us-ascii?Q?gB+nJcIESJ+4DvrDLqd4H5Jwud9429S5meolnc9RPZqVZgHGhzWi108udX+M?=
 =?us-ascii?Q?Y+Cxeg8ClGejx6OkhTbsSpUVPe8OxvoKHO3Hyj9H7R9pbxNZWrT8PGzcJQ2T?=
 =?us-ascii?Q?fjLQ2GgGizjcpssj7r9Bq1StTsqtQhDDFFVK2d864Jw+YhJxEdetFqezFUpL?=
 =?us-ascii?Q?cIki8grlfUXEtR5f3yi6NPJZEGJpaBEuJhUCvFV9W/ZOJd2CjX91PLLhm66j?=
 =?us-ascii?Q?cMdJ6rwP2KPlyrR75XSSfXDwDd5Cf2zMolKeZcobDP3q8LlrYiKEBAGrp5eK?=
 =?us-ascii?Q?p+j8zaMLxRWHGnwOLlQ4Fe3blwYJZaU5uhGpIhPqIkC4s8Ow1OCtvNuMdu68?=
 =?us-ascii?Q?qM2R4sAglwgWoLvNfJs97k4EmVZNkCRABiq5FNV8l2s00Xht1Pe3DbrQQUV+?=
 =?us-ascii?Q?tOuiAQO8cUa0g/GsktGm5k6N/bYGKoMdCQfmLNEIEBfrOrpaJxCgPHg1XEAE?=
 =?us-ascii?Q?91ec63nvwr0G8g+YVvb2UgOwm+54a3ra/CbodJHZOkCA51dAGMJG+Za54Tf4?=
 =?us-ascii?Q?k5Y/GuQ41ztI7mCv9kriWbi++kKhig4fYaT6QsrCs1MFzuanVYw7+UIDrsXu?=
 =?us-ascii?Q?ozjD5D5fbpDfSkvXbI5NcoTP+4bKbqoUBkFwTTyTQTb/rsD/cH0lnYLPGIWr?=
 =?us-ascii?Q?ulbd+6be2AKiyRrL1Dd5xIe6vyYBOCpLSMmdG1ERglcXx1sK8AtcgeuW6E3J?=
 =?us-ascii?Q?8K1BxLHBA0OSqi99oqftrJiZT6VX2cfTk1iSqpkO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d557f-2c0f-49ee-8a3e-08dd1e59d483
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:15:32.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsFC4umf4Px8cqi6FppADGLNXIEVP5M+7IoaVKLfevtAv3PjrDn9U7axRgZeeaAEgBbP66jCjvlqiA41LrAXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

Device DAX pages are currently not reference counted when mapped,
instead relying on the devmap PTE bit to ensure mapping code will not
get/put references. This requires special handling in various page
table walkers, particularly GUP, to manage references on the
underlying pgmap to ensure the pages remain valid.

However there is no reason these pages can't be refcounted properly at
map time. Doning so eliminates the need for the devmap PTE bit,
freeing up a precious PTE bit. It also simplifies GUP as it no longer
needs to manage the special pgmap references and can instead just
treat the pages normally as defined by vm_normal_page().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c | 15 +++++++++------
 mm/memremap.c        | 13 ++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d74e62..fd22dbf 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+					vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +216,12 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/mm/memremap.c b/mm/memremap.c
index 9a8879b..532a52a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
 
-	if (WARN_ON_ONCE(!pgmap->ops))
-		return;
-
-	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
-			 !pgmap->ops->page_free))
+	if (WARN_ON_ONCE((!pgmap->ops &&
+			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
+			 (pgmap->ops && !pgmap->ops->page_free &&
+			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
 	 * zero which indicating the page has been removed from the file
 	 * system mapping.
 	 */
-	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
+	    pgmap->type != MEMORY_DEVICE_GENERIC)
 		folio->mapping = NULL;
 
 	switch (pgmap->type) {
@@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
-		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
-- 
git-series 0.9.1

