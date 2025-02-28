Return-Path: <linux-fsdevel+bounces-42810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6ADA48F5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497187A2BC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E01BEF78;
	Fri, 28 Feb 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TsNOptE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461E1BCA0C;
	Fri, 28 Feb 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713519; cv=fail; b=dxTEoMXIFZUL370kqSMthwi34G9t2Pbg3270JRNmhn9t7kY3S823uzbJHDj4BkHPMnP2xbYiYDweThmI1eaDgUco6Oj9z1Uxn2Zf6Wr9RyHwQamRj60XYLs8dU1lxaC6v8Ix9+N5lmC3IkUXryB8Jh1lZeXXK60Qx6e/0eF9Aks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713519; c=relaxed/simple;
	bh=ZFl0bMSvkYnGwGxulzK2Wx03/HzXumTTTPwKcq3OAEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEFcZBr7WTuYz9C5YyARFCNZtQCxdlz2FNwS5M1rgnO9niZNL/ETYdbts6UMMTCQ8cQrFJxGpbRpr9TSYuGi0rynhBCAEWkgSYlxAgUkjG0fZy9TzoTrLe3JbnVBjrq5NsmzqLyW4peELzzcrtC5Ze3eg41n31V8k7k/h50DLZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TsNOptE3; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMZrHcF4OKXpm/vE939fXQ0MOakSji0qF8a7N7NG6Mkef8D65VlNRTt1KUeDA8iv0ckdA7kv2A0xDRGCip1U++ae1G+2JrYO7qCeAFryZWMZWvZ6uRXjIAoQXWNkIGKjLUdGiDHyP8TW9KiOLfuPODdiQRwwTOBC6waRJ110eL97YlglCXCVouUBN0rzCArBzIPOahhxw6ZVmeFupYTfcWqscdBfe1kO21jyCws93oHdew1aQqaQ9KuylRv41zVBKrlX0IdxYSfu0nZqPoTSlmu6exsmU5sDprburzyyR+WNTbHb8v+Dr14Ia3xP57qLegkxYuU9FY1uK+znIqcE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tvVmUd8MTa61zBY6TluXmKwkBsI5wuLIycCgCcsc2Q=;
 b=sRUqUkwmqAXOU+DgwpkhnqeEJyo66la4UkcWj+c1RNT9F+JQD0eW0XMPJHzeyDt+cbzo7me0tE99IhDl3pxi0yZofaKHABEtFNHz7YOfBSM/6qGOs0EKaVIJ5krkww39GcQmWmB2hEPN+j/aZefM3unZHYRTKLexGhp1x8XJ4bmucGG6RP70myETXSkaWbNUziXbLJwWUuVwBdtI3H/R9BeHFDHhuxL1/2ZK6EQIO+iWoP1q1V6wzQYpdWeReG7Q3iJ9bx5BubBF4mGl7ICb7kEipuBrPU2vrbidafRkHOyUHBhGORAHJSdPCdtd/JgfHEvIvYGHRLPpOsWrd9eGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tvVmUd8MTa61zBY6TluXmKwkBsI5wuLIycCgCcsc2Q=;
 b=TsNOptE3eO1VQJam6ltyTEpFD59TN8Yck4G4nF5zDfrRcVabqx9lRzQZ4uKLwpCGJHYj2dFGwPdK4EBPaSt+BY1zIWM4KJ39gH/2Yr06meUEr1hdtQKxi/u72hh/bij4nO0QAA+Gx2l+d5YxbyClA+wNadzI2CZEPxDd4YR4ksxG8lwKr1MeFSxWxZPVDOyURXEnCLtxtEbp87+B/gXQZZeQPg9GIuUSJqU9vw15odDfEFBHkm5u6Bs+VUYzwA80EyVBFK/EwchedeUiqyYCr+jZyPCC/BVEVHTv540vVLd+iHEQFx0xq1LRNIL4gFKDBmNEHZ6CxtKFKWdXS+2IkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:55 +0000
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
Subject: [PATCH v9 07/20] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Fri, 28 Feb 2025 14:31:02 +1100
Message-ID: <2d3cf575bbd095084993154be2f0aa7442e5cd28.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0086.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c36f48f-c702-4d74-0d01-08dd57a8730a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cyix02rE7G8bJNw6rd1yKc1SBIqX8b46Xco1Lc1/fUtQyxd4OFwtbwUALnr1?=
 =?us-ascii?Q?7gfkr0qAg/uCe92qgT8443ksSv3WGWEQFNVPNoxvQrr0YFNiTLDCAZPIFYjH?=
 =?us-ascii?Q?I42I7Zgnpsyw/0yOfAADTYJ1Bvga3A3Dy9nh7g8DW8n9D4R12FPNQvMQVAUT?=
 =?us-ascii?Q?Wyu1Y/ds6A4kKPZ7+MbthUDXMbAZ2drJY5ZcNHWgKz6cVhD9rjh3XWX5DRzE?=
 =?us-ascii?Q?CR2YV9ulsMyop13X2nnT5vwFxsaiqr2K1rifryYu1ijujS5vK0IxmF+B7yCl?=
 =?us-ascii?Q?R4MdRQUrlcnKHbWY1jxOgv+dFRWumRPx2AoJgSHJKijsvKbhHTI3BDJ+aXSw?=
 =?us-ascii?Q?JU2nd5RauH+SCLjJSSI87GjyAXniR1cQD5XIcC979jDE/W/akmTL9extFSJx?=
 =?us-ascii?Q?WBiLws4Lk9auTDLfqLsHPCdhwZXIffdzNnXMLDLyVQKf8ZcT7TqYV6rsZpNh?=
 =?us-ascii?Q?kkxYaQHsbWt88Or28nXLDc/pWhrmp71iIAMJYyR/kpXw8UMCEMWyA7C5S1PQ?=
 =?us-ascii?Q?FnMuQRfn2Ru2VyJYDLktaZytuNTDoGmAtKsz/tf4H8zVrIGVvh6h9mNfXtET?=
 =?us-ascii?Q?Tk1pvbziqWfNb2POQ2Oup/qxpOwokD05OzxyLo+ETecEWh8fOU0+6Lm90DkV?=
 =?us-ascii?Q?v5hDZx9fCsY/eEmQuRvGnFdVR/jnIXDGvV2pYAddlB9pwm9ZBe3YDHCxkEXE?=
 =?us-ascii?Q?PZqdUWBVcYmZhJ4Gn6lYOZ+PO8wKgsVcVXRrr4xX5/Pv2+O3wmFxNPd0ViF1?=
 =?us-ascii?Q?UQKFj0ly9moQcoHFkU/HZVsMnt2MAjUnbiTLqAxN3U6rF76FiIKKw6XY4KbE?=
 =?us-ascii?Q?w5fbmUGUSutf60BrGkEiB87cDXZm81or5PsIU/LJz+0tPYJNliYmYtdt2pER?=
 =?us-ascii?Q?BiLuovXy+Sym5m6SO0VHSyhWgRu5oU/LydB0rqwa9marjfXlvT4wmwwrXwct?=
 =?us-ascii?Q?nkWt4UzjaCxRntpUcX3nj9VGZMh+dg+n8UQyuUjryqui4YqnjD2f2cWZlNcD?=
 =?us-ascii?Q?whniTawsykhwuYvNzCWj7mdy014ONBHY5nW74cmWWf8vhtvqCd+JEinhShjP?=
 =?us-ascii?Q?cUrWkshvos7FHgHTKdmxhsyWUEkRHuIE3VSO+R+b9w423z4GdUbMsFP4eSou?=
 =?us-ascii?Q?t7zvLZURzuQmFPyRT/XVCFBz1yvv80vY9rST9rJ3p0FJegRP74DztMLRkfBa?=
 =?us-ascii?Q?3ttxJi17fMzGEXfjgtweR/fjoivIZmVKXJCSTb8JS7Kuc2I8Puj2k2Ycsi/W?=
 =?us-ascii?Q?juYxaEpDtJKHvFYDXCBDtpDnvK3qiIWUztDnCLf7huXqLC3FRpIQvTaNdthR?=
 =?us-ascii?Q?nABDt8LSIXndtaw0nGgMY3+2PBBVpn9e+g0ofdJDzVPpJdNpak0mu88NbQtF?=
 =?us-ascii?Q?sV/eLXO6+5mofva8oBljkqj8X3Rq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV5kI1JWw2fVPL5HgAmkOArKonRODPpMxS7Ou4sKyQm/mQfReLfyr1dQ5XQa?=
 =?us-ascii?Q?409zZGGdSsThmmCCSaYYSG4YRTAoYyt4u1njW79AG7NMdzpRI2b+7VIr2gBh?=
 =?us-ascii?Q?gyyY7mam+JWMnz6WwC6uPXd+/5D/a4jiNBV3g9Qpz/WYKEhSKsv7XOuPXQt8?=
 =?us-ascii?Q?FWwlzx0KeBdxlC505eWKXq8o5N1EP/H79/JJMsisP03zsvZ/ABqEhszOLbHD?=
 =?us-ascii?Q?nPWOT+uNZ5JO9QXP5VBRCDQlYDhKc1ibPk2qHcSjAPe52XF3iMpjfuTuWksZ?=
 =?us-ascii?Q?MveRWWMFnMXoGwapgWDuJbnIC32cABJWQswVceitCHvH7sRo1EMjT1eB5jja?=
 =?us-ascii?Q?gvd9nkJ74J48iR6ek5hafnqxhDW/AwzjFAYOqDp5VGqVyJQmqJcpZW5iDaBd?=
 =?us-ascii?Q?mvzLJ1PqW1jNZV6CjEJHTbQRkYLKr5aLmNW4lTLa9vDNgnWpxvP3XvzbAFRy?=
 =?us-ascii?Q?fDbqtcrutmP5Mif3VE2oH6JnLAuehT1wnELaf9NzNwmytX4sAtgBDlHt2VKw?=
 =?us-ascii?Q?+L2uKqluCZPIKHThf8J24hG/mTYjsGI206WT5W7t6LNic2hIJHrvLgKpcTTP?=
 =?us-ascii?Q?QiNGtrAvSVuW84JdxFr4paA7v4AMq4WVjdDCrYzyeBm7LdKABHyFXB5cb/6F?=
 =?us-ascii?Q?V04wmUTuTduLN1a54c6nDJmdMq9OIwdnyivwB6QHgY6NeUv5nAExKEzc7cD5?=
 =?us-ascii?Q?G3DRNBiBIJWGdomH9pQelAQcRaz6MWRuVJbPgYR2jNTeIAEfnzx495DiFPxY?=
 =?us-ascii?Q?f2VMHAV+1YqaNC6FeZndAQE4FFMLAzF63DX1jKJNMPCgsWaw+SbBvcaswmp5?=
 =?us-ascii?Q?LpYosVjOoUZJV7KG0erU3SBzObJ1K9lDmwRpOe5dKe8XmDOVNRfQl0fGTxpe?=
 =?us-ascii?Q?X3zqUCwAkZcD8cwDjRU0pLo/blxW9G9KJrh8P2UOaVqHNFj56RVLnplnbUgH?=
 =?us-ascii?Q?aASATu7XMWP5OP+0mnNNsB5YoQU9dRWq16SPgUf60EFygiOmLQc4Ign88lj/?=
 =?us-ascii?Q?BxLu7alBcQ4LUANH/dYTLxGnognaBj1BQeULyPSplXDWCP2VNIKs/gh/YHNH?=
 =?us-ascii?Q?JonqNHGy6vgBCOB6oIiE6A7uyEayuXzTLZGmVUX5qXtrTJNpaic6alKeSQC9?=
 =?us-ascii?Q?afUaZIbB7blnJrx80i3nQjXPh0fFFNNe7MH5PCZmApJCNrRb1oWy1wbbnioU?=
 =?us-ascii?Q?kgfaj4fTYQxjZRqukQGrXupXkzQuDXZOgHQW21buGkPIEAVg6mhrHzKfuGHN?=
 =?us-ascii?Q?nA22v53gwRErDTLy+Ddln/pEZrhuCQ9FaZIFm0lPsK73wFv1ztOV7EG3RWDj?=
 =?us-ascii?Q?uPDqibJVv2kjymEPc6Y2VwtPuCpHRIIRWaVGEhO4IUC1XyDiHyub6hy494s+?=
 =?us-ascii?Q?kHT/L/js7Qmf5i/4E7mFZO0DTiYzYcimrRqtrzqa3BAYBlOBD2e0Kkk1miES?=
 =?us-ascii?Q?B57nnJ5lZ871/2fJkDcmTlOkfUmOXQoE6q8K1ueLQk67he4txypmF2dS3mIt?=
 =?us-ascii?Q?i+L24LUqzR7W8Raj18zASWk21gay+UPUwz8JP4bOn+wysb3pfEi2h9Rm6yMS?=
 =?us-ascii?Q?AzV+FOI2OY6RhAdgqXV1C4ZxNrfts7nSCNUspu2L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c36f48f-c702-4d74-0d01-08dd57a8730a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:55.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz9QN5zQjgQJNIeDOnAv9YmTdqb9ZsuP9CzG0uI9z6pzaVrZeKRMIQqX9/6sXLRy0xWYxedXmP3FRLqttzij4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

File systems call dax_break_mapping() prior to reallocating file system
blocks to ensure the page is not undergoing any DMA or other
accesses. Generally this is needed when a file is truncated to ensure that
if a block is reallocated nothing is writing to it. However filesystems
currently don't call this when an FS DAX inode is evicted.

This can cause problems when the file system is unmounted as a page can
continue to be under going DMA or other remote access after unmount. This
means if the file system is remounted any truncate or other operation which
requires the underlying file system block to be freed will not wait for the
remote access to complete. Therefore a busy block may be reallocated to a
new file leading to corruption.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v7:

 - Don't take locks during inode eviction as suggested by Darrick and
   therefore remove the callback for dax_break_mapping_uninterruptible().
 - Use common definition of dax_page_is_idle().
 - Fixed smatch suggestion in dax_break_mapping_uninterruptible().
 - Rename dax_break_mapping_uninterruptible() to dax_break_layout_final()
   as suggested by Dan.

Changes for v5:

 - Don't wait for pages to be idle in non-DAX mappings
---
 fs/dax.c            | 27 +++++++++++++++++++++++++++
 fs/ext4/inode.c     |  2 ++
 fs/xfs/xfs_super.c  | 12 ++++++++++++
 include/linux/dax.h |  5 +++++
 4 files changed, 46 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 14fbe51..bc538ba 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -884,6 +884,13 @@ static int wait_page_idle(struct page *page,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
+static void wait_page_idle_uninterruptible(struct page *page,
+					struct inode *inode)
+{
+	___wait_var_event(page, dax_page_is_idle(page),
+			TASK_UNINTERRUPTIBLE, 0, 0, schedule());
+}
+
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
@@ -919,6 +926,26 @@ int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 }
 EXPORT_SYMBOL_GPL(dax_break_layout);
 
+void dax_break_layout_final(struct inode *inode)
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
+		wait_page_idle_uninterruptible(page, inode);
+	} while (true);
+
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+}
+EXPORT_SYMBOL_GPL(dax_break_layout_final);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2342bac..3cc8da6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -181,6 +181,8 @@ void ext4_evict_inode(struct inode *inode)
 
 	trace_ext4_evict_inode(inode);
 
+	dax_break_layout_final(inode);
+
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d92d7a0..22abe0e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -751,6 +751,17 @@ xfs_fs_drop_inode(
 	return generic_drop_inode(inode);
 }
 
+STATIC void
+xfs_fs_evict_inode(
+	struct inode		*inode)
+{
+	if (IS_DAX(inode))
+		dax_break_layout_final(inode);
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
@@ -1215,6 +1226,7 @@ static const struct super_operations xfs_super_operations = {
 	.destroy_inode		= xfs_fs_destroy_inode,
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
+	.evict_inode		= xfs_fs_evict_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2fbb262..2333c30 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -232,6 +232,10 @@ static inline int __must_check dax_break_layout(struct inode *inode,
 {
 	return 0;
 }
+
+static inline void dax_break_layout_final(struct inode *inode)
+{
+}
 #endif
 
 bool dax_alive(struct dax_device *dax_dev);
@@ -266,6 +270,7 @@ static inline int __must_check dax_break_layout_inode(struct inode *inode,
 {
 	return dax_break_layout(inode, 0, LLONG_MAX, cb);
 }
+void dax_break_layout_final(struct inode *inode);
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

