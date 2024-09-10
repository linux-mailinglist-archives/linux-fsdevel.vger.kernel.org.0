Return-Path: <linux-fsdevel+bounces-28980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495997281D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6391F1C238A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805AD1917CC;
	Tue, 10 Sep 2024 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hS2ezw8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E37190674;
	Tue, 10 Sep 2024 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941740; cv=fail; b=WmbF0gS2fBUyN+ukvw2WzQN85pfjVYqcjX8CsWJdx2/SzTQTUKXHIH+0BHMR26bQKI+qrROjO9Mq08h6FB5UaW1Ml6scwSFCrRdfGzP0MfSI7bOZ4Ps7AGEjw4RAJiegBW2IQdhrAIRZzAv4Vi8tGEWO6aW2Enguc8BwXN6lYYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941740; c=relaxed/simple;
	bh=Rml4FOtNZ4oTMo+4SWtnuHmUqWSdD0HggTagsoup7w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYSMZxaTSJFrp7r/6OkMdONENI2x6BJl/qaFPOBrQXNDtqhvKPPDtRjGjFcmA3jR22xYZh9f5Jv0AYecA1Ir59ItiLx4MVo3hzhyFySRBaRLT0kz0vTxX0qBuMdFMb9sEEmyiZgstPdGzYKYFTktQPTHhYzCEX4QzYoGrFj7Jgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hS2ezw8+; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZBaqegP2yi+3HEsP5rP6SWphwz0NgmuPRKqrcTPzQlqnnh3rxwQmvb84jqzI1SbjPS4kUO/QlRQsJ6MLHWt0LxgW+7OX3skfETvioHYu+PZ5fJEEO2IOPHQXIOTVBKkYy2ZkWzyfj3B73HaaFwuVizL9VP999w11iCLDUWfoAXw4diIdttmgedwKCeICTkkGUmcy5hU1fDI0qWwrh3maYP+UuOUbTXnlhH59h1fK5PSbRt1WGsyxR8K0BQBMsYtxecvwy7GNRAW6RnEMJ7x0HX2+we9n/F0U/mfzite7Jo3tG0EfG6NcTnjyhEDwkXh9xn5p2cwCT+q3Wn8yG/YjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmVmguBDaPXZcKaagi7Z+K991/nm44PK190JdcuA+tg=;
 b=Zu69LGT0mUtrJOIupd5Kd12sG2ToT+DA0LEDol/NJkfmUXQAhi77jG2aW+tCXhT/ueYA0NKSSE8NUMrMvZirmpgdjI5ofx5T+FQpqyUcxCDYBHedhdvRgQcIhDq54+rGnBoZ/di9UqqAEWkNyNt4t+1FTZQgfGQZd3in1q6KAy8SRzrtkZhyZhxEB2BS24hZftW+Qmu4ByymLIFNguUqhwexIVTGRnl0Nn4RLpTqIxySai0uAbrLyHnEDDzWq5PCHNOVqPp5b93iuD4Ny7uQcyIHb9t/qRXdiNt0Kz+Rs3UnBJqdKtcpIA5Fyrfz6VyIxn8QOmsyvP2aRsfaz2VL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmVmguBDaPXZcKaagi7Z+K991/nm44PK190JdcuA+tg=;
 b=hS2ezw8+I+MLJ2F3SgAVUJQTBaY8y53MZtqrZeZxcX2nQo91JgDlnFL86r2bv/BSZz2Uwl3hhaAvoA0BDzXVkErE/Vw8Lsozm92KvTHu3byfQBs621gdxv3yBLCXfwPp41dspzVRXac1XfJjVuFbfQmNf9nooGYtIqdSmZqnMBx3b2+xXobjxNCfspvjdPMflapjdL3HASWIn0g32EKbpwvVU8UwJhIqUSVUrAlsAUv0C1pTtXVAuzbu5hp8bPSRNxZJkZ7BB+/PyN9lgFUPkyEMRvhHod1R9/P+SXZSKfZiNMMUMFT+ELQ/eZldE/0U6RLNXucHlTK8XP2/D+GqrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Tue, 10 Sep 2024 04:15:36 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:36 +0000
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
Subject: [PATCH 08/12] gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
Date: Tue, 10 Sep 2024 14:14:33 +1000
Message-ID: <78b49fc7e0302be282b4fcbd3f71fa4ae38e2d5f.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0110.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d92a199-4c00-4b0d-b7c4-08dcd14f385b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+IfuPAs7XaJc3M9yDU4ghwimT9Ez+RziZdYS1X3rruWJD4fMmspjCzE1uSU?=
 =?us-ascii?Q?Qr4fBQ4dVyFm1RsBHjsVBHRNFlTXdwFRkoldYQGdybvNVo+iDqO14q0nphPU?=
 =?us-ascii?Q?wwcnXqRTjYIsgdr1zlSWOjCn9NRu/km9Ng0KuFVaPVnXuYS4xv+3vNSTLGAn?=
 =?us-ascii?Q?ddF5eH2Hdg0qcNWoPOLKDjz2H3pDO3+IU586Ku2fJDJS0/StNJsG1y8U1eEX?=
 =?us-ascii?Q?53svdDpFXQ5Kj5DIMKa9MnWzLYZegzg1hjy3/nj62BYMvHtIIKTBWWKiIxnj?=
 =?us-ascii?Q?cZxowChsLSOUlQDzmx0+E7uJwrX4Bvn+mxs0lRkzRA2p3L7YzgiOHE6//g4E?=
 =?us-ascii?Q?3PSf2/nVf/ZeFmKDSdoctm3akAu6WoC2GZoUqzftJx4e4A8ULZJlgYrNoGTQ?=
 =?us-ascii?Q?RvaVxV7SXmHmQRHmUEC9khEFdkYSku+++muyShMfBRYDCEQBH6PBG3RgRl0R?=
 =?us-ascii?Q?oFfJhOZfS32GWaAPWEuIVbzYPH3WLWIhdtov9NiEkE9IqtsvLSW9NvtPjrYS?=
 =?us-ascii?Q?ZQUccQVZbTHanfjmMbZH9Erfo5ZArnyqGmtzQanpxquQtpeM17SUU1X6nxec?=
 =?us-ascii?Q?ModG/2Nfh1mzm0M8x9UcsApV+AoFzJDq/VTm+Ugn0L91UA2HpuhdYGtofY0h?=
 =?us-ascii?Q?EsGhl8s1U7oaoL9IosofhNodm60cNLAQRqQ/IC++yXWm+Tz+anhqXyU/yubC?=
 =?us-ascii?Q?ujEDeEUGe4Peg77GomhRaryzTi5ID43t4AVIAVE8upYOWgQYXfaazTyTPewR?=
 =?us-ascii?Q?abwoxfI7q75HRK82B4lLAs/6ZxrGJYcrq/wn5Bz0FC02w3clztW4czPJboVU?=
 =?us-ascii?Q?vAWfcrQAzfHyFINCkMh7Ypkagmwt9wl6zwBWNjdD8sam6+WpZsK7qYDZz0Lo?=
 =?us-ascii?Q?rwyXycTjtru0k+TMlRA66Sa6IJ5YZQdkDeRebjOZt4WQGK2lahXUzOWyRK9i?=
 =?us-ascii?Q?PpVxg76OSiKDFUBV4KeUdRKXk1CeBbzdNwYzXgd9owAw4Vat7QF474ojoiR5?=
 =?us-ascii?Q?dwvqalPZ5oAcFIYEk4YjwlmHXG473ZsfuCyM7Rm4OzxCICA+8zR/UTrAFeOB?=
 =?us-ascii?Q?v326iwG9dQWJKoR0QvUCygu/5GTD+VzDZA/RwVWxq1QACdQeD/irKyroqXvR?=
 =?us-ascii?Q?AiAHhhImO23T6FSHiddV7bdN5omJrFoldaziiqcE+JpPgpwVuxDDSzPOrNrr?=
 =?us-ascii?Q?3NCG3SKBkQZdA617tUBdFiazZnDy1kj+lvVqWM0ywLSRdwy1SKsoBQatjbN9?=
 =?us-ascii?Q?5/SAvsxDP7lVOocVKKQSr5nDEnPr687ix2a/sUjGXtNwIYdEXmRKwFbvbEn/?=
 =?us-ascii?Q?H9BU4OpzPLwasj5OrHsPiVQxC2AA79eCo8qitcZ5ooKQcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5lgFlHP7AzaYSp3mkzVPbqYuTtAeWoEg1C+f0xOkrXprZR2ZkBCc28IqRn3?=
 =?us-ascii?Q?ORx9CgB53vzROsRRMtgtC9bOfvfS90Tx3rWALkBm/g8KrozgWe1aIjhECrLZ?=
 =?us-ascii?Q?PgdxrAt29U3J0GVap5yzyEzcZcqqd43B4FuNzNgUyWNvqJBVIzhqBX1lYv4x?=
 =?us-ascii?Q?8Hpnps7jTVnpukr2hisq8M37qauC/GHK1iDxXcjT08W35a8jZD0acWWIKbL+?=
 =?us-ascii?Q?6TTqliv96vLIOHnmfWxJMyZT/4qNTVC+PyMYuaSS7MhaYds6YthfivGeP7YK?=
 =?us-ascii?Q?d55HM7NT0glcxd3g0ODW2++LYAJLUxmZnXEnNdmsN2jEMMad13HJU3A++TLE?=
 =?us-ascii?Q?dbMVhydYFvjxiP6GgN/JQAla9TAPkSaih1x7/50wXXX5fToB4DlBr9F9mt1/?=
 =?us-ascii?Q?kU09dSUvbrZqUb1qJC1FvAabUhgcQIe2inaQYX8RB1kpDoAmgoOnsgBKAbx1?=
 =?us-ascii?Q?jhlaGYZ65ZK7Qosa4Fw7I+jetlzko+pyOUqL5IQ4JrAB6Rg7cXPGaYB7it7H?=
 =?us-ascii?Q?Z/qfMRKdXYUo8M5uzYGi0BAZ9bhLMVqfK5EkZoPN9YKz7mPCmKiypcOQKKsD?=
 =?us-ascii?Q?uERRasrT7PXpfQlz+RhcIo9JejwrIi2hyyOhgETyrxA7/fYwEZ2mgTo4YLTF?=
 =?us-ascii?Q?1e8ULhdoes77tyXFIH9hjkfv4lJnneBaeYUSqihWUiwT9fMLeAVVSZgVJ5hg?=
 =?us-ascii?Q?9u5bePDOcZ0J0QziFx1gBZ0i50fvoDOfTgTzWi3Tk3cjSg4g02sPitgum/67?=
 =?us-ascii?Q?XoBXjCh+oYYliZiE42Ua0VSeJYrAu7iPSk4jnZnzCffFtE66/pnxQkaEpFsO?=
 =?us-ascii?Q?kQr6xahDuS3FjLXXulKcRfbnK1Q4DlvQhANwjNqAsVhHgHTdroYUUITTaWbG?=
 =?us-ascii?Q?NFIyxGpzOgMdxZzLvM7fVFfTipRYSHYKeGBgUdPMUZ/yPP+PiIsipDtUiEdH?=
 =?us-ascii?Q?bNJ54tTmpi4CQMHoG1hLCjjrBfX/B8rd3cZW8X/T2W6HXa8gWyuQ4FU+iC5u?=
 =?us-ascii?Q?HR/tMn1tQ0nF8JLtrh6J17Slb2oFg9K+Xcf8sKnLu7G6CVFHDf4d6mcmduVM?=
 =?us-ascii?Q?YIOHG3MobcCVuCHq9JXX3v28OVBCDHjRnPbTuEZL8JA97uXeT6KDeJkUCnHT?=
 =?us-ascii?Q?hP1N3ZVdyEJOYWEkgsRDoO09+bYtCZELWQinb26QLYqm+1mqufiyXq9KpRqI?=
 =?us-ascii?Q?MYBm4G92Kbmhi8bogdWLePblI4Y0SRb0hmyKx4+61AC0S49nkeFY8iqWW/fA?=
 =?us-ascii?Q?iTpVkQSAqNYzY8aG3GoFWaxkXVXeHKzDDxcgeSjzLYiWFKk78yCIGIW9oBmr?=
 =?us-ascii?Q?MPBlQqjhCKm3pumDCUUO7mNH+P4AYY82n9MfH7Gi+kLNlJXdqhC2PIKGVwgd?=
 =?us-ascii?Q?nU3mzpHBEMW7bwFaSPt4fwDKZseUBT277HO/ejjRjZk8Th24+SZF8jRtf9eJ?=
 =?us-ascii?Q?VqYMCm1d61dzM2FOtsGt4OQedwG0RsKJzKQfjtt0V6mU2W1cJAmoTu3hOQCm?=
 =?us-ascii?Q?IF8NsCzwYxPoPGq8awIHfpA2VgKFCGRvWzgz1LP7S9MsGOsuzfoSogrmxKAt?=
 =?us-ascii?Q?9x65Cd8c9QSUXfEYE2UIPo9gGIXZk6qhJDc2z7mU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d92a199-4c00-4b0d-b7c4-08dcd14f385b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:35.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCSFupX6de5G6UEizforjsXwcCeAwCCJKj9mo9MljSe1339BjRIwjChs0P15VJepMRxtgE5Zl6tg8OZDyndtOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Longterm pinning of FS DAX pages should already be disallowed by
various pXX_devmap checks. However a future change will cause these
checks to be invalid for FS DAX pages so make
folio_is_longterm_pinnable() return false for FS DAX pages.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/memremap.h | 11 +++++++++++
 include/linux/mm.h       |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 14273e6..6a1406a 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -187,6 +187,17 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
 	return is_device_coherent_page(&folio->page);
 }
 
+static inline bool is_device_dax_page(const struct page *page)
+{
+	return is_zone_device_page(page) &&
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_FS_DAX;
+}
+
+static inline bool folio_is_device_dax(const struct folio *folio)
+{
+	return is_device_dax_page(&folio->page);
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ae6d713..935e493 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1989,6 +1989,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_device_coherent(folio))
 		return false;
 
+	/* DAX must also always allow eviction. */
+	if (folio_is_device_dax(folio))
+		return false;
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
-- 
git-series 0.9.1

