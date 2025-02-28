Return-Path: <linux-fsdevel+bounces-42820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F3A48FA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A6B3ADFBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE51DE8A9;
	Fri, 28 Feb 2025 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5kkdWEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1E1DE4CC;
	Fri, 28 Feb 2025 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713568; cv=fail; b=mn5YuACTquJ1Aiu6DWcJqlChmYqtdHetYKMGwzMmOL0h3ZNYNTH+HoYaZMMeKPkTGn1ULPvvyyr6ToqXcFX10UCxtMf0wcBojy1Yr4Extbk5HXuK0DEU6gd7P/aULFlFVm8P4/7MlrGYRu0dl/mQsZis+0tLySjbfKzYdhFtYm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713568; c=relaxed/simple;
	bh=0OyNXO1+lCFhiTVcK+8x0NuTlGOxtzcFv9cygOWTmMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPCAvuoLwkBqFMV3CFuwlnwUgPSVw+P0SUjEur45dOpveg/GZuE/iveI29zZz+3NEVGnLkxclVJIJB4W6VH3grWq57p54UDnRoc+D1gtn5Vu5CDOh7ahU0ImlCEhDKEkyh9cfrNe4dluKerMLB7veseZWuezMUNb/HibGICxI2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5kkdWEL; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKPYxj/LhcO75zkrJSvXheE7nsnAPfofAe4bNu4GpAaEL73Emyb6SHZvKnWWbpV9AgC01perdAb8BdGeHOKmbg1pY/GFitjpcv50vcZppzoockRA4seahU9CzimM/eFtd6ZT5YCy6e1PmfI2WfOiUboWZISFc15p9XCclh8b00d8WTryiRgxkwYJz8Mq49Dbu8RbN0vSI20U4zX4ttLNxaAqBwJdtPP01KyeW17gylapjO+5iGvwGYwsD9y+mBibw6qNrbGKWxsZlCpPUCfe5NXxvLaqA53Dr2HJymU8ePvVwB/JkVcOWm91HsBjZ6yce7L2Evv16yBOlZAGLepXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VENjcw892hS6S6Ehnh8sjwSOcKFsy/z5WoqOWPzB/Kc=;
 b=Qmd5QPfRQ1mBq9XoYSyJonGdyy2k0Nc37Bmk+NVIJqsE+pDmuzb5lXr08U1g8adc5kzd/kti3otuM64r+apwK6Am1CXA8/0QoTZPjd0iX2iByhEsj1psFUzgAzmR+Yxlaw1eC2WJne0YPIf3W5+XOklwWTm/KKN2sYzHeErNJTf/w8qHrEQT096WRTXhZmOB0+AosoVeJnT643Mz8tK+FtPa4aPiV6kdvYAbXSYGCHiVVgm80//EMLGrQMCEvXeu0ER+Ja5dHdgX/YXqxdUU5N5/SveZpKvto0AFZwtzW51Q5wrZqBctv0tgR14/0YCZuI+1ziJQ+JYFRePFUdUoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENjcw892hS6S6Ehnh8sjwSOcKFsy/z5WoqOWPzB/Kc=;
 b=d5kkdWELQG6vgoc5cQu+L1d3pKPR+ymTcSNkDQiWnqCYyrGjrcJz5rEP3Ycu1IpP9J6tLIRSJuu0PB7TsUZeyEdFRW8SADH9IJJlIh903/t4I1Xx98uW4ComGzva231dWQiCi935f+mER6NESpdqpoZlIcFd2FS6aaw27hhQspln07fq5W5YQKJrQzLCLBEvrcBCgmyvkxYbdrbb7U+J04oSp0Yfy/R6SW+g0mK+/if13bC9oXnwjN/MX0hKl6T0jp/qJEgapOvl5oYUdT+LonqT9g3Z4HYsyR3vDeSkRIgtdajY6vCYfK5jZnv3NJ3PLTeFvbCdFv+5qrWxUmmaUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:44 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:44 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
Subject: [PATCH v9 17/20] mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
Date: Fri, 28 Feb 2025 14:31:12 +1100
Message-ID: <250a31876704b79f7c65b159f3c835e547f052df.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2c25fb-8a8f-4ba5-572a-08dd57a88ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PaVWVr1K7H5NLii5nNPL9JPr/H9C6/2c9vY9pve8oNUDmqVpGI1t4/qnrznB?=
 =?us-ascii?Q?yHvW30NoC4tytu7sn5lCRWCyIzDJHO7XpUw4p3p890iiw1llmnCWVUxRbsRy?=
 =?us-ascii?Q?4DUaoeeoiRPOus+/A9DnMn3hcU4IzDPk1ZxOshZNHL1zet1nNZwMoTyDPlhR?=
 =?us-ascii?Q?FgniyB7FMQhWP8QcS0lTaPBOtNbnJStX9EsKo/gCWAUHhPzWsJw+Y6/EAPjU?=
 =?us-ascii?Q?bh0VE1LrE25qxLPoDECitMSzLlSyll/XXKwq2Ae7tMKVtdmYxcBPqDvJt1IX?=
 =?us-ascii?Q?0Ktdhb0xuxPvTIcAox8kJ/0kWOemjEiOybh9u8AwMAdZiHpzVeQXepedFMZ0?=
 =?us-ascii?Q?yOvsVtP7xMCeyq0H5eaNzmKmFQUeYcHkkL9aE+q7wIRythXtgUDMFN+3FXNF?=
 =?us-ascii?Q?dxZlHBNOFYM8N0vtkzKNtNgaphMuA6zqcGeyL9AX1L1Mdt4PJ7q/Mj+lYCzF?=
 =?us-ascii?Q?k4AzY87Sgc72uJHPoxbzzItEqQVkoXd7x59oVAEJygT24EY0Od3xwsGkZLMJ?=
 =?us-ascii?Q?jgT6zvGdD/VlcpKT77SnS7M4RjtNed+QJRL/datdiEE792cVEaF5jXKZW05z?=
 =?us-ascii?Q?WuUsZPkGwxKzBD4ORWMlvFW6yst6GYXgO/uhXQUOLDZzuCAEzxgsbqWOltSE?=
 =?us-ascii?Q?RNdBF67d33UNSxuQvtuTDh7ccQ7zpDzWq1oeJ7Sc7z76qM98V5Z7cQcuIYHi?=
 =?us-ascii?Q?oUc2g5zGB0pNocXpJUyQeGO+k1p1d5BYld8eUT5tO6mSX2KoKbI0+oLXWBX3?=
 =?us-ascii?Q?ovCub28NTcdWgyTrrfaFLas3NV0rtJW8gIxzjczzzf4kXgEG4eKKib7rlXE/?=
 =?us-ascii?Q?j63NTVl2dvzDbviq9xmOrKaluWmBwHu79UNd2/FtN33CRtZVhLFTkmratSQX?=
 =?us-ascii?Q?81WGtc6/yiwK+pMHwVrG3fxWp6PP3+D5yqG0RvjEr28nNFmbSQG7SgzP4UC+?=
 =?us-ascii?Q?VAExCKUsCnqtNn8io03Tzr+Xm3qw4Z6ZLtMUUtbxgz08BRK0H8zHGHZuEjMA?=
 =?us-ascii?Q?POWiiZurY/3lzqDRmP4ege377mbIxJL4obYPplPXKrj9Mkks6t67shSjsVpH?=
 =?us-ascii?Q?uV6upG32sRzUzA5+ZyiRsKtlIa1/g3DNkfVZaVThR15896DUrtSut01lH3Iz?=
 =?us-ascii?Q?rFZeuRHgOvXJ7xpLUhZ+jDCCtSRgAmqVnGT5/qkOPWmg+BN1EDTGpIzBipZw?=
 =?us-ascii?Q?BfBg4rdvKKnihUiBCuOMpbk2QxcEz8fgPXWgqODnubFutMREs0Po8YOGFdxp?=
 =?us-ascii?Q?yGkOILXqw7NFzPemwuaCBjsPrF6MB+CSuRSYn2GKVJqFGGKxjxTLJ4j3ALFo?=
 =?us-ascii?Q?IVgpNA6+3Xhyf8EFDNccG2gudGwFcV6xl+bOaQoMwTV6B/IK6Qp+iPR3mpfq?=
 =?us-ascii?Q?o7LKyA1Lyef7A3H/XD5PW+ccn+L9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17+2Yc0d+py+vZTjUdDAr7fRzfwqbkVIKmDpHPYCYweOcGCJjsXMlCEB1qso?=
 =?us-ascii?Q?jdrjkevm1Qg76gRVyCoc7qUOurDu21Rh9iDmjRmpJgZfnNLdltGj/Kw0dcDX?=
 =?us-ascii?Q?k8RtKGcu7NVuWoiTDKYLxM4l8NY0LQp6ctdQW6APRkvWG5UzTssEiG+XqC9z?=
 =?us-ascii?Q?OMecC0Nob5ylQSpkSP05EvmGMSY2lAHA3RPQX1wBb9PfDxNJc3CveWtoEHpy?=
 =?us-ascii?Q?TnllV/x/ob3Y5s8tCU9L3vZETxfu9pV2YTENG+Qt48O01t+pdh9rCelNrqB7?=
 =?us-ascii?Q?yXeJ3V0bNr4001YDqniHQ3csXORHABVm9guEgXxKBnGx2MDQbLeRkp85bBNr?=
 =?us-ascii?Q?E3XUVa1pJoRJZ4pXfCtGR1DFst6KxE6RzllBaWyy+IgR4kjIeG4vI1nW2oTa?=
 =?us-ascii?Q?80gNioVpsupvKPzbYS9fbdOEL1wStJTnY1HwpqZJPd4xBWBZLXy164/gjM+1?=
 =?us-ascii?Q?NOMOiLDdEVhZ0CS+YEZsHywd3VvIbh/lPBGC6X9Z73e0Ih8Ln661n1phz8t7?=
 =?us-ascii?Q?QnyTH3+QSG6NVEWQSkZnNhGGHtY92Dxf4mrCuIqn+kadLWJt8pOPWtBelFLK?=
 =?us-ascii?Q?xUQ5LgwQygWaTM6mVBSemksTZGfkwsPNKNd0fQ5/4r3x4KnbDdEH8PQ1HIc/?=
 =?us-ascii?Q?9PmiHv2WkXT89K38btOfRb9UnqxRkGC9+8YFTgZ6hmWFto7P+1fdg4i5/5YA?=
 =?us-ascii?Q?e9cp/fM4dHk3OdR6G8GVFYEChGS9afKwugEAOxiQ/7I2UPKYxKzcduQCohpZ?=
 =?us-ascii?Q?MbQsXepJ2EvokPPAvG6WDpY53rT0icw1t3OqD9IVcltnFt56o8GKMMTtAYa3?=
 =?us-ascii?Q?CoRX+50pY6JPCz3O26FKZtfGGol4kUKycB0rBM5bPRi/qGXOgt07ehlj7bOx?=
 =?us-ascii?Q?5StCd3BD+yHMWYsxDkxxK/i2zfe+h2fo6W+uF0ApM/vTaSyw7LqQiQpgIncQ?=
 =?us-ascii?Q?xhTQ19BLXk1oouLOnVTuxTAMOYWn2u8JMyctXTNv9d7DAFlzd0Eiwn+uLyxG?=
 =?us-ascii?Q?qGYKUIREbDNW0GAksZOTP93UJ6HCB12NZsPCY794C8BgiJ8WYaLbPIlvYGDs?=
 =?us-ascii?Q?74OVNVpZBl7Sfkty72e5h777P8HHr1TcWk+WPj/xYpwBFmGZv+I23T4aQT5Q?=
 =?us-ascii?Q?53Gz4JSQzw6GuyO2qde6EX16VnrX/inSCyZSEA1YHZo5Ofm60hrg7NKw/SZb?=
 =?us-ascii?Q?sZLKGn+1maNVQ5S4ZGHRL7DWBtrwLyuPNluYRCk3K53aB1p+kN2q7Khluv9W?=
 =?us-ascii?Q?wzILPm+AanJk8GQ9MAGCBbkL6AB3TLlIoOAhjYMYD71/3SRTRuKhLVnfo3dE?=
 =?us-ascii?Q?dhRqN4DmIywDPHYGtQDiod8kOfNq5x0WIMDMvyqJWDSZeihZTVcGdnFdYqWG?=
 =?us-ascii?Q?qlUry3JZb50gZd0+sCODuO50ZX3QWvVu3hVTPEEPF6LKy9sm8h5HQYfbtxlw?=
 =?us-ascii?Q?5YGTJKckj/6h/MfHcRTV2vAN6yNs3AzTTaZMZhFY+TF5kxdGyQM0k+The6BF?=
 =?us-ascii?Q?3YBv6/1dIFElyw1BZKGrHKY2mcegIF18YH0Tq57Z51LXu93qCdCqaqiDd6V0?=
 =?us-ascii?Q?G0E/9RTIhel/ahxVNKUMgy6ijri/F1YaFP1urGn4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2c25fb-8a8f-4ba5-572a-08dd57a88ffc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:44.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDAa6kFMKEQ5qBVpvdjk1gPaNXdKvTW8sYUxiL0TtTRzQgLoT5tqtuP4Elj+bcYucUbL6Ot3axIuRPZby+DkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Longterm pinning of FS DAX pages should already be disallowed by
various pXX_devmap checks. However a future change will cause these
checks to be invalid for FS DAX pages so make
folio_is_longterm_pinnable() return false for FS DAX pages.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memremap.h | 11 +++++++++++
 include/linux/mm.h       |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 0256a42..4aa1519 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -187,6 +187,17 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
 	return is_device_coherent_page(&folio->page);
 }
 
+static inline bool is_fsdax_page(const struct page *page)
+{
+	return is_zone_device_page(page) &&
+		page_pgmap(page)->type == MEMORY_DEVICE_FS_DAX;
+}
+
+static inline bool folio_is_fsdax(const struct folio *folio)
+{
+	return is_fsdax_page(&folio->page);
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d1f260d..066aebd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2109,6 +2109,13 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_device_coherent(folio))
 		return false;
 
+	/*
+	 * Filesystems can only tolerate transient delays to truncate and
+	 * hole-punch operations
+	 */
+	if (folio_is_fsdax(folio))
+		return false;
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
-- 
git-series 0.9.1

