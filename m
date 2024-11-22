Return-Path: <linux-fsdevel+bounces-35534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A69D57CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CF71F2341D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580921DF97A;
	Fri, 22 Nov 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9HGgjvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1860169AE4;
	Fri, 22 Nov 2024 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239793; cv=fail; b=RVfVqB5ri/MTbJziCggyvqSaYHZxV1cgxh1+7Ufb4HATQG7zVXy/KjPUyQ0ltIWshU2Djs0v9y9xSD4vKGVPL8hkrwHa9KSecP7am1UNfw2B5ugfpl97hC1ZQaxWloJJU/QOSR589u7Pu0/7EQGqgOHptIUkt+7uv7t0aM8v2ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239793; c=relaxed/simple;
	bh=LvWJTKncrqEz9V3CVjZ/oNdrwzKuo3VO7pA+GM2GRKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQpwDB85Msk2p22+m8hTGkUr61duH0Rze963s6hnVD+1MDoZiMQovLuaN7Lvf0982J6rkDM/z3NhnQ9TnPGoZQeCDCIgc71RBeqw666tnXAlMzz6x8thSCvsaGC0EJ0bGQzP1BxQ1BV7nYhOe9JYg7U/efPIecFyV43FD4zVlpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9HGgjvY; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icbA9pL/B28q+U6ofgArMls7koavVNYDRvwDlzy0eVmsPvx4gFzg1FJYRHS+iNrVEUpyePQkqOhLQ66SYWWONpsPEpcis+ytiBJ6hQPMFVKqZvvtpbheahDgCV5uf8OhGYzCF4SAppoQnuxsnwApmwdQUGMHVWZgxIiYX4NfTZnaS6I5lghbs7a1mRHebEc6LRBHHiPMuVTfI7rB8nx0Vaj1eICs7gbfgJdt4+Bf1l6IWoDE3hLzjph1ascTA7aZLvuuVMfpuU7BoRYMGrbslDYf1uz0P80cHL7mTeQ0zeCzBaddx86OQCFRH03aUqhtQB89/VlFfbfZ+3NE0PLRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD/illaP0OIVmmCg6mzj5RVo8vUE1Tl9cr1eNsTS2Pc=;
 b=ltwGYHFXlrTiEtfHTggpR9LGfJ4rK5klgbr8ILi0WfaCY9GYyNkneL9gFju2dVlNOeVU5VV16UWVvXv4ZYLnB8a7bWhJseXyyK8HMYMjaW5OC1swff4Q6ry2sc2HccZMJs4NVzKSmLHg0WobOe1XOu99fm9awBx/vP6AcNF556HoUO1aY/p7DuISqRfEjRn6sL6OUxe0l52xMqd0gR4qx5uppKXho1BUCPI5o2TLniBOKnMhYXVyS4BJjayCoX42IJn21DEawKeNc4kTYdxELOXVzWXHqCrR8fHWPEoRqwKE3W0JzY0cWgt6UbpTI9K0JRF4Wq8vXuu/Q8YiN/Ds9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD/illaP0OIVmmCg6mzj5RVo8vUE1Tl9cr1eNsTS2Pc=;
 b=p9HGgjvY6yo6EwioMWZKxQA/sAfvshQErH4jekym8hymDnDgxrY5AMWB82tDcbUciByFO21jaho/mRllbcZjcclU+dLNpaMnZk1MbCIfiYzsMyD0bvUaata+v258rBMR7Vi5kPQsbwoDapOws/v2/5mYZjNuXTeQHjfryjNITtAhaey7zP8Xu2H9kiMFQD8bpvcbQ3yH1Ueosfts0nqgPy9rkMRkFD5ecppAK/h8eoe8buTK1hiErgdbCPSjnr2Eazm+zIHeAMVBSC7vO4Xp0iIaxcaXqAKLDQ+S+F1/OmcPSdW7vUq1uF9+9x+Y16F/dsBhKMIn77/6PaJqnIgdaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:43:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:43:09 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
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
Subject: [PATCH v3 25/25] Revert "riscv: mm: Add support for ZONE_DEVICE"
Date: Fri, 22 Nov 2024 12:40:46 +1100
Message-ID: <f511de7cb9817e2e2fdd274ee842c228d699abea.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:1:15::26) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 02028ee6-2fd1-4714-1731-08dd0a97049b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35hYQCfm4jU7I4LEDTDao9VtBktIBFxZw2KyX/aAxf+OrS4SQy0QiPR19p2Z?=
 =?us-ascii?Q?WjjpK5nwqKpFAodh/XqGCTTlaFL2EOsENSjthoBninSOeSwiNnHW8J9wO6y+?=
 =?us-ascii?Q?jo8+JZd3+mOSnuy67fpL1nV/W+uIra3avtDZLeqxelT1KsLg67sSEREScPeE?=
 =?us-ascii?Q?8d5E7fwa5JJD4NjqEkjITK162X097aXFqeYpkEYwPpCkMIK4MbE3NiWyha5+?=
 =?us-ascii?Q?NDovbA7Do5gPKFzORrWc0LJ5i67CGBDynMnVKTqwIkHeWv62Wl5K+V+SjqlV?=
 =?us-ascii?Q?p8inT2ygKobhaNLykNkF5YVllZLJlOXVWzrQyTAFZGTdsWXbhI1DZZNuEIPd?=
 =?us-ascii?Q?dBpJBeYp3BUFucL4xXIXEpQBiV0hgObJEWhuM2jm12irm7xSD//Apbq+dTx5?=
 =?us-ascii?Q?VYQ9XZDC9vYVwLhmdAlE89imXO4h0BTEaIBT+KVWpQu2lRS8MxOW/8nL85vR?=
 =?us-ascii?Q?WtRpGk148tW8y99oaJ+2/sE9q2Bjyes8POyHrMFPxD5Yd4xhYxA9/hKmzRMD?=
 =?us-ascii?Q?+wmRWrnpmWTIRrtPnWwkOJNG/55AYOniohnSGOYF7o5JOfZZOz+fOP6ABLTT?=
 =?us-ascii?Q?UHEvDtIbbI2e/NZxbeAmF5uDabiUC8CISFU0LZXHFT1aEyJtMNb9K6jrBsnL?=
 =?us-ascii?Q?QDkWFvHUZdhF8xc90jmhniUXZ1+TjOZrhIL2QnFEZnwPGUOz4q2CzvkmAWwx?=
 =?us-ascii?Q?P6XJkZpW4wjWoe0/5gSk1eYwJ2D9DV3t8w0XUoac1mjt8DNWR9iBFR/fDyuQ?=
 =?us-ascii?Q?7RXyJ5Y2K6BeiaNf9SGkYOFLiNrhWvgAeh8i3TOXTh5RMvROFlKsvbPX4nxm?=
 =?us-ascii?Q?YvZVZezb6oyapiAHXtVErsgyyNnYlohMLNLUanWZXOZu3ycIvkrWceiJNef4?=
 =?us-ascii?Q?mxcohyO4YgLOJ93jfo29y6jCtqJBIcN6P+ZBBYEt0hZvVN2ZtJ2QR+qfH/+r?=
 =?us-ascii?Q?zW5gfNRUkULpAyfdbgBG+gZvwHXmaORoTfkjOl0tDrm1InvbkYi0+Q9zr3q7?=
 =?us-ascii?Q?A2K4yBPEJZJkvMaQxHobKLkPG5veTStjmei41mM7sfgTOy9pQH32alwaMY2H?=
 =?us-ascii?Q?a7DT1sfhatB+jQE5NIHekl4CNIl44ryC6t1hncqI2qpZah9hNiL53V2McXZI?=
 =?us-ascii?Q?HByaUJsVtN2kXm+Dho4dW//9jUmwYr1HyqoEgef6AE729ACiG0IvXYHGgS9e?=
 =?us-ascii?Q?kam0/IgoA/HWLNgxiqXtutoCWaPyKbA7AORvHxzxxKHVtG3o3XbUN783uhol?=
 =?us-ascii?Q?LVWihFXS07Ostt/Lu1easXbj4uXSSy9XjnxqYclqadvQ+IScI/TlP4x7Ek3X?=
 =?us-ascii?Q?F7bV7thW/Ob5xt7QOaUFOANR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iEYq4pHDworgqm7emTaayj27+d/jtMOZf3cRpeXN3gFIdWBzf8SFdIT82iDD?=
 =?us-ascii?Q?4TKGGSjkbew6gQ/CP2kPVUGc3Cf5TXz30kVclelc5GY4LYLcZjiQHEe15oUA?=
 =?us-ascii?Q?y1tOPUMyKi8Z9OSmXuhEviC2a2xl1+EypMVMQhHA3KTWhSCrLq2otMm5tzh3?=
 =?us-ascii?Q?qDe8Cpspl2NsfBGnG2v+fCA04G+xKDaLOzM5+q0HcwNDBXLg0FheK2xuukFV?=
 =?us-ascii?Q?V9SqgyzQfQra5lCkR2e2nRL9vUU3mhBtU7INYL3lQEgHYzApSRxpOhQ/vvwf?=
 =?us-ascii?Q?AYlc3sHs2IiIZmx4VuWyaDBvlJjn3Emnx+yF+UtIMjdUiWRkRigWwM5jWoM/?=
 =?us-ascii?Q?8LDqzYtM71chFumWNSJNR0sue68XubNnDgMsVqTA/junTVcD5KvJotw6+C0n?=
 =?us-ascii?Q?RT0P7l6nT6dGI8uslFw/SWMp7sVCMC8aZW66rmNlOgJ6TjRJCdgDrLM1Ovwc?=
 =?us-ascii?Q?LNwzqTre+K52P2DKb4pzZxzxGhAdr9sWlqhTZ9qA5GiLLBejuW01+64u+/kK?=
 =?us-ascii?Q?VlaqAEQxdEvCPHPLMGJDRauSIu7DqterGLNAQY9JfrsKFejEVRm2LfSR7UmH?=
 =?us-ascii?Q?hZF0x/R+r2LSRBYiyCq3xtYSTXJ6Y2GPcPFF3gzFR+yq+Ulq1lNd3qW+c4le?=
 =?us-ascii?Q?R8Kfojwu9b62HSWHW1PdPfwbZa2yhqg8XMf7QWctVpNomYWYKakuFrkJlUjD?=
 =?us-ascii?Q?S4MCkKP0gg+XEmhaIMtnNSHYXv+kd+5TgbggCjh71+8EXfeP2eNb7BqAad4K?=
 =?us-ascii?Q?tCscsuPNLLoyHGh6FXECBsQoR+AZOKIV8CJKkhGwqXgt0LpqYURxXAhUcyV+?=
 =?us-ascii?Q?EPlRwI7ZTu7PT4g4d8N1u5LcUFwu7UH0kvDMmaFwZH6NUu2RnVSVjA7c6CYZ?=
 =?us-ascii?Q?aom417sMc95ESsDTl8OHsojC4QM4t7YjCWQnIjg57xvkEi696NTph64RfBMz?=
 =?us-ascii?Q?QGTEgnreNlMqRP+ESgsNjMpGiz1xm1B1JzJx43gJnuAosLxaPbtY4bG/qFjL?=
 =?us-ascii?Q?sdr7/Qy2R4yjAJTezJ5tIVRCCGUb1IHGNpgIaNRuSNv7sJ2XLv9DhT6ZXcLh?=
 =?us-ascii?Q?ExYO5BJHooyrRrbS5jTVuQg/wstOCy8OeYyLMISRMc43AGe1ENrpFOGbS7r4?=
 =?us-ascii?Q?gdE+1zsrkigjpxcJ1DDYmGJt+13t5kfjqfhtXxBmaQEV6Ux6qvZsQMSwHIVe?=
 =?us-ascii?Q?WEVTjH/hFbbyVxouYz5gaG9JDjUuONdbAkZDxxcJaIi3dsB+dUxz6yIALPt7?=
 =?us-ascii?Q?Qtd3CkgbhkPefGrcdSjSj3km9BLzlifIkqerXLdIkFZ5nl0V0jfGeOgwkh20?=
 =?us-ascii?Q?RXiB2ezNUC5eptX612p9o6R1QZ6Gu5cwiwIUYsyLwHdVj8yoUz7fBt+VjUYb?=
 =?us-ascii?Q?Cby+n2pmgchwp2ixpu0KHuw57eT6FC6SV9fruaYUJwJegxp7SIWPJsA6S2Yv?=
 =?us-ascii?Q?IfqN3ZdCgINuGouDX4B+fqS5XMHLZbzVFrEhTwwAMsxo6QK4sU7EJ1DFl63w?=
 =?us-ascii?Q?Aaw+xqttFmViR3AZzdNec1e+xphLcps1AtOieWfxM4JUWI2AWOBlr42QUv0k?=
 =?us-ascii?Q?QCbZXL7UB7EUS5tvhaUW1P25LunlsLhg70+6vZ3M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02028ee6-2fd1-4714-1731-08dd0a97049b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:43:09.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxvc/hMc9bPl7/wdi8drZNOC8ETUpk5vSY2WWBsMN1/h9Wvm9qoQ5B8x23IfX41oVmkX2K8PqyQ8mKzhcNtkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

DEVMAP PTEs are no longer required to support ZONE_DEVICE so remove
them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 arch/riscv/Kconfig                    |  1 -
 arch/riscv/include/asm/pgtable-64.h   | 20 --------------------
 arch/riscv/include/asm/pgtable-bits.h |  1 -
 arch/riscv/include/asm/pgtable.h      | 17 -----------------
 4 files changed, 39 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6254594..2475c5b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -40,7 +40,6 @@ config RISCV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
-	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd9..8c36a88 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -398,24 +398,4 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pte_devmap(pte_t pte);
-static inline pte_t pmd_pte(pmd_t pmd);
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205..179bd4a 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,7 +19,6 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
-#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e79f152..93b6571 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -399,13 +399,6 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_DEVMAP;
-}
-#endif
-
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -447,11 +440,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DEVMAP);
-}
-
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte;
@@ -752,11 +740,6 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
-}
-
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-- 
git-series 0.9.1

