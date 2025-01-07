Return-Path: <linux-fsdevel+bounces-38532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63485A0365D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4718116472F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D371EE001;
	Tue,  7 Jan 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLOxUWns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D691EB9FA;
	Tue,  7 Jan 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221453; cv=fail; b=OqJLhvcs8c2LAs42TowXmGVaxdBOVyl7tFPtLMQiapZfZC+aQE3/CqbjWtIaORH5mygApNfxiBs3ZCV9kHjXWAz0I/UvRDv+4/5riejh0SHa0/Smsr9Gn09Xf6K4LnjpfAKztcD+pgm4B+lHi359ct7/ziVMBEAjGjAfZ1Suld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221453; c=relaxed/simple;
	bh=EMUj8y55ImNGdqZpx2JqfX6OpWn5/JKz0bu8O0ZnOn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PaZW4MdJzP7pLBx1tDDJB0KtgjyB4ilIgQHNsvuiWBp/tF8iofRJUnSHpcFlsve4C3GTPAiSUqmu4hccQ/WqDBkoH/SEkXkK74bOVCUki8717fSsYKH8cQ0c96x3O/DHtH3S1zXkgxozKjjyn//tYJW8npY23f4YSohd4qu26zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLOxUWns; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BheF+p5rY9Uy1caatuW5UIEu0Z0+OxBSYHac0TPFhD8igs+mbPGlE27cYacIJDPq5hDTS4uJA9Pmu6uDx9SdC23n/n1VwLukk0ROM1VpWZCPLhR7B+2pcEUf+ASctNDep4VmeqZOYWTRCkopCOUrj2UpIH5VZfCBieSxJr50fh9oV72wQWOAUpBYUUB1R4ZEuMbJFTwaWO3SuT3+CS6qjc4c/NRJFqTNQD+q6qfqhizu5wpdAha6DwWLgbNZPUpwdNThZK0YdogdltTbFZdvdesKswOS0MycPbDyqupJlxq8qrNVltqyZoDRWRUcLeof9ucPbm0B/p+MT29I4/axZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXlKVA4UNAS6jz/FYVqiQsIbN6kjrNS3U8oMzkTS/a4=;
 b=xzeRU1E9VsMPSod2CXfx6NzI3xu37Zfxm/FEUtdcUkAkcb1RcOVtNyKoEXzn6nU54wKQDuEtquk2VgsvrwoReMw96C2PwFupKZvgYYPs8ZE1FfFvc/E2Ht80eEnmx5aFPt8B7/T4cIFbxWWrXmi7FqHVRevb+/VP4//BQ9uz1b/hpKhb3MaHNaCeh6Gw6n+cAmEMyyEF6T3pkMCArA68X05V8+EvZiH5dHgh19KcrY0o7yPAg/JN0XRc5uahMU7BhUJFBlaG279nFbTt+Kr/8PQwtRJ4cveY8+xyjMCHQygPxwnmjH5luAu8zO65NxMIT9h6BbMi05eCNH33QNnZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXlKVA4UNAS6jz/FYVqiQsIbN6kjrNS3U8oMzkTS/a4=;
 b=eLOxUWns7IIqcskCfzJEhBveQQUm8UBwxv/udxDghupc4kZ49YwGqwDgf1NN5q0fxSHE81of2uAoqmHkyi3rUSM1jMnDpWOx+mHYYB6H9iZMW2PG9MoC93w3d7cogN/lAcVY2VC1yI4alZydbXBUjAnDrGbkpzMj0gCG5Ls+g2f67bu28xF/1rNCLrK1rXyDMkYEOIrsoL5ZEd+XfTQ00xa55QEDJd4HKnBvvnhw578so3AhOloAa2fLGURalJQXfLt9HUw01Do1bWu5nDrwZGxScRZEI6+cObRr82ZzcLay8fIInrueCDcStGRFHUO8O7Qxt674Vyi3fWmGF9IzmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:44:02 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:44:02 +0000
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
Subject: [PATCH v5 14/25] rmap: Add support for PUD sized mappings to rmap
Date: Tue,  7 Jan 2025 14:42:30 +1100
Message-ID: <8830827577fec4c6c2a0135e338723a5b532a2ee.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0141.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfaeeb1-0c05-4c75-fb1f-08dd2ecd869a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBVqDZIWexmsgwnO/0LmdNnwDJer48d0TZugSt3bcE/NzqfklBhHr3/oybEo?=
 =?us-ascii?Q?uurf5mQ9gczU3c5Ez9wT4lJ9ZPi8fHVE9clPLBhBYRW7+qiT2ZoVUe9co8B7?=
 =?us-ascii?Q?MkzcMuA6BnrbN+ZjQhpw+WQxifmiFn2X1e1XirxX+qhGBbsZtYawYXtAyr+9?=
 =?us-ascii?Q?x3daHOBWPxd/1IR2Z9GRsP+B4vQTHSajGjTRXCT/nj1NYNXQ1X4rljQGYzh2?=
 =?us-ascii?Q?jvXso+vKczj/Yg40YNrifZrKDqeQCC9ThUPwdjJZXQjsj44kzr+cri8RG3yY?=
 =?us-ascii?Q?sdMJ551LsbAmSqnPyh+2NdDHzk5faZoZx9wbbyuulj3YkZ7s6ojU2U36aM3k?=
 =?us-ascii?Q?86m2c+HI/mv9J6QLu6Fm8yGgOC8y6uZtEu7bfuIlcI/vZPWPhQgfspAQNPl9?=
 =?us-ascii?Q?+IgO6kQV9cXdn/HErkl7d9/ChXFxpIYr9s0drlL4mWurN6ZgBgRfxhwWwYHq?=
 =?us-ascii?Q?ELTb9u1m67in/t7tG0/s7jKXJcx28WDlMedSJ3ZRV4Qi+8uAxln3jUmg/1xM?=
 =?us-ascii?Q?e/HLJHljJsSAaX+uGIt7+y5DSfAJOBvyDc7akVx/rT7+xHf/DnxqiI9h4c7K?=
 =?us-ascii?Q?5QSg9wI93jPjdSZmrw21UeU9frbJusaffmV8DCYWKvJgZC2PJSoS5DplseEZ?=
 =?us-ascii?Q?aAgn5fgZaFK114rWdMSyz+uGTNfd5QoUEQwM3uTsCZrMTt/gF7Wn28Ge97ai?=
 =?us-ascii?Q?JIRtHD/Lwdi9ibKNxFYRAjr5Y12edGUo1L7BekuiYydcYq5HDWvgLdXDg1Tj?=
 =?us-ascii?Q?VXlmTZpqQf2a3x28kIr6XNz7WXjWyDlpSZ3vLnsPb7vJfXqL9lo40Dl9QEXs?=
 =?us-ascii?Q?d7yuyx1uwky3oS7a14QMnJ9aGKKHVaRu55HgVPln+x9slg9mVJ9AlqVhfjtb?=
 =?us-ascii?Q?NBIF8ziKVIMVLrZsWyrKf7CYAmP9tTgtqTERKphJSztRIWNxKWX0TZykiPpP?=
 =?us-ascii?Q?DzZRXrjc08L+mpGlpMOza32irNroOvjC9PIQ11pR4Y1YJGjmvKU1mDG+QX8S?=
 =?us-ascii?Q?ckbGRCL84AQDMVtH2SaMW9e5qStd7Be9YA7aQ++D6DO04vo9V6m7Pgg4eVZG?=
 =?us-ascii?Q?OB7R+5uWPVL1W9hHctLt2EmvjX1EmPdCqdonCAyn5V2AyPBE3j45tx8VD21H?=
 =?us-ascii?Q?2syPRKDQr0zpwRiUcmnnD42Mn80jUcb+JfQYltJ98lBkiHC1G1r2Xqm83gII?=
 =?us-ascii?Q?Yd1kf/YNgKzg0XyRgsvfdI1XwUSuuNHYhsMXb20Txpp9Vt6Wk/EabKSI+UFB?=
 =?us-ascii?Q?8J1Y6QKVfQlLnmTB+xEAGFOiNlClIhtMYLs6k38MSXUyZv7m4xtMDDtXHx8E?=
 =?us-ascii?Q?dbJ2YWCJlOVlP2Tt6quk9UvgbkLfjYYgJcVu5Z5a/RkVlfTw92nwTv8gGDid?=
 =?us-ascii?Q?M8/6uPqcprFRTfkLY2Ss5l4+bl3s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XTDa4xkd3PSNoom+fDhSZ6W7jKK+uo2HTBsWz7tJ/nBewvJchICVWT2TGnZN?=
 =?us-ascii?Q?x1m2790y+cK615Z3D2iwryFSFG2qHKng2OHSj0MuGanAiLm1ts36vqAH9JC3?=
 =?us-ascii?Q?wVLsKkTm6znLlqeI/DjK2i1PJKgExqs7WyY1o2wm1mVgI1Kc6hz46O9kJUV6?=
 =?us-ascii?Q?U9ip7kscv9/A4svqDyDaUyykdZdywGlerS5tSmBMzKNrc1vvsXK4FeF80Ng1?=
 =?us-ascii?Q?B7knENsZyGfTUquGEb8f1YhxPMdKkjbHPVNifV036n1+GCTYzNUm48pqcGpg?=
 =?us-ascii?Q?KMVOJhIEobSbx1RrxPtIbm6AdEpHHfjFYbtnvHNFLJEam0rjdW5XQnH/Q+mM?=
 =?us-ascii?Q?qb7xGONSDs2WLuEAIXCvBGeCOIrjZWTsGL4FWYbD4YRVsv5UJ9KrNXVXBZ8u?=
 =?us-ascii?Q?aoEQaqUCordWA4qYa4t3MUxqOlsv2mKyEwsvo/i2TEm2JU7ZebSqC8014AiK?=
 =?us-ascii?Q?SnE3iDz8/WNDYCyhx0fybDYOlmUNQQIkH2JoIbybGMXKVK/1xBa97rYvgRq6?=
 =?us-ascii?Q?HHnuLaro1/lLw17e7bn73g2qBmVEgssjF5VA2Z7GbhBF4pNzAlxhQ1mKj9uv?=
 =?us-ascii?Q?IjjcAkG6PZquYVehvUa+LjeC+ud+yi4JoYlPdOH8oro+jGO1s9823T1L4HH6?=
 =?us-ascii?Q?JVp8OSNZA12qOF0msUtsVj7QCULLAVZ/EA9Dv1+MyveNJcnCFT8VTuDk+8NW?=
 =?us-ascii?Q?u40/bYcpRy+5MhW43BgRupoOJjS8+MfFzJucK/AIX9Ti/PwXmB8D5dfjRZFI?=
 =?us-ascii?Q?yhH+WoGsIlr1KZCez8gHR+ZNtQOhmjOogFPyZbx/WvvSUpg2jqafa9gTyzj6?=
 =?us-ascii?Q?p312vHcIUBwoL0atOZouTwSCNgNmSV7PvK/sB/0Y/3QKZSet2PYovb6HFhWs?=
 =?us-ascii?Q?itoC2fPFRPqAy3Wv/S1pCZSN3GZ2PKwPnp4O05962EgREpmoJIshVsbE8Usa?=
 =?us-ascii?Q?Jvu21bp6fQu5C1eHZGzFkcAY8LA+f/58l1UqK/o+VQkRQ+u6Sme2T2E4ldGX?=
 =?us-ascii?Q?woyscvxtWKZ2qf707URblICX4hnNTnt2lHpW+xWEYbB9WJOPl5OV93wWxQi0?=
 =?us-ascii?Q?QIPflzMS43Sy2B7KzgFspJpcDO0I+mSG6w2vnhS2In6pew4L6cZ/aeMd5PSv?=
 =?us-ascii?Q?/ARci7eRDe3exTptObBFaHXep63xCOFXvy1NdhW0KXaGSYjPEvYrtH+c61mv?=
 =?us-ascii?Q?SKDwzYo3eFA1PPDD1Q9ukGlvOaq5TxGc8bOJSsxnhC2fr6Ak+4iQSzw4KCiW?=
 =?us-ascii?Q?YfXmprN/yxs+mVEnyoi+38zVIC7Nc7qYy7FfPFTfvJ+bzAm1h/+bVkczeoYs?=
 =?us-ascii?Q?s4J2jDdTAXbXcUr0yuZkyG1hFsO3YOLKdn2+g3Q6GN2yX5fqD3x0mJolKi3M?=
 =?us-ascii?Q?aKT/Fpsq9OsuI3/FuARhXGRVR0j2/lnRpaDNxWZgF/8/ur2ZsD48dhG5CQOr?=
 =?us-ascii?Q?DsRUVu9dZMlpFMWNs9EbioM8HWcHH0D/gp6Tmljf5b1V2tjSQqWHKrSSTYcE?=
 =?us-ascii?Q?YEDFPzFp2GB90d16faCbt3YoObtSIIlsTlfaoi0ih6QD/AQnpCUI5T0ezwxG?=
 =?us-ascii?Q?Apib22yGFVGkgrZVMrLaDFwM9T9DtgUwotj2JJ6d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfaeeb1-0c05-4c75-fb1f-08dd2ecd869a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:44:02.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ/l8VTxwG1IBft2XAQ2vlGtRPHkc55A01S7qGijRRqQZv77Re3PLXKRjml2FEBwvQZIhjT4ZLafc5ZAN+aNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

The rmap doesn't currently support adding a PUD mapping of a
folio. This patch adds support for entire PUD mappings of folios,
primarily to allow for more standard refcounting of device DAX
folios. Currently DAX is the only user of this and it doesn't require
support for partially mapped PUD-sized folios so we don't support for
that for now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:
 - Fixed accounting as suggested by David.

Changes for v4:

 - New for v4, split out rmap changes as suggested by David.
---
 include/linux/rmap.h | 15 ++++++++++-
 mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a040..7043914 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(const struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Assume that we are creating * a single "entire" mapping of the
+		 * folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_add_file_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
@@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4e..227c60e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1187,12 +1187,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				*nr_pmdmapped = folio_nr_pages(folio);
-				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				/*
+				 * We only track PMD mappings of PMD-sized
+				 * folios separately.
+				 */
+				if (level == RMAP_LEVEL_PMD)
+					*nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of a remove and another add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1338,6 +1345,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous
+			 * PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1531,6 +1545,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1560,13 +1594,16 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				if (level == RMAP_LEVEL_PMD)
+					nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of another remove and an add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1640,6 +1677,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
git-series 0.9.1

