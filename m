Return-Path: <linux-fsdevel+bounces-38536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF4A03675
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D1B1885C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715281F03D0;
	Tue,  7 Jan 2025 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQvN2DeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8F1EF0BC;
	Tue,  7 Jan 2025 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221469; cv=fail; b=eos6DtOioCldmRV5OXp/mUBPoizdySUv84YE46mw7GACGG8jdXENnjzhPZpfJhT6aEBi5NnKK5shyJOHCJRFD8D+ob9BY9gsA1WTGAHqQWq/cHFLYH4ih3XyW5kx0Nv+48bB59C1V18a7c0u8n/QoHdbhjznrNbttqbVvHqhnhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221469; c=relaxed/simple;
	bh=dWaJOYn4wnllJH54JaYu53qYtX3ofzwwSx1ZUb1uUCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGMNT8BuTU0q5N6flp9IdJPUuWjf56ILZQsE1QqZfXGkxN4kRKCksJ29SGFmgQ2ZukT5aBgLSypgcZnMWviH5mivX8shINNndtjbD1WYjbRnLU6AjkEMg1mgWgosPA3zG9pmIyvJmWke3gqhc5sr9Kc3pSwKuIeb33pDSYqMMYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQvN2DeA; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjbCVGBoH4uIQcuJqo3emNoiaX4VuPzCCDz8/caco1311x4fHFKvSRUp/Lm73wKlGE4iTy7jbSeONzyPqaRTTw3Wih+kOmHVelbtZSbDCevlZZZgzu/ouVWYY+bvZFNE+kNEcF4XjsCbkHFUS6vkc0uhPQTb4nBy06Gn97TD6CBsb4potCz3RcrKBa+zP0bv3KcglG3PFB5+6tnt7pOKV7JzrQqF6kkj+pzhdBMtgEmQ61jspqJq9AM6iPTBY2rqMVupNPHAktU7W7PcdSwSk/y9TttO15pFWo9IJ5wGyvQySDcQWjrXKB1UUYbiaGfEMvNsPAM3g+TMIXl/IDrdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck5XiCzxtWS0Ep/kZkIuKJrjA1hdch3Ab631Ko01rm8=;
 b=T9ZT1HBFUZ4fzX2vMqDTitEcEehhzdl+cAGdXMHl2GtKZ6PVCWGi6Kdly9s/xoocNnTBN4feYdSYRa1AIgbu+A6hL171N5F9OKUXSP+h5eSJOOxZr0P14Z/ug9NEdcIxp6N3j29tDllbF2ImvQV+QSMTBK4ik3FYpE6he7++dD6d9mwLYAu4OXTgXvopLxrKI0bWu5gw7oQpWAPndQrIhQF9A21ANYK1IfxNknpKtaGIyKBVAoOv305FABJ7RCgdssswZuhDXK78RfqnabF3RfzRyy2SjqJF0TvE37xojjXvQw+ALwKyB15Meb/LwpWnbkNSNtcnOtRspHMe2VL3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck5XiCzxtWS0Ep/kZkIuKJrjA1hdch3Ab631Ko01rm8=;
 b=EQvN2DeAAbhG4EZCCekipC7TWsRB81aaiIVDKGxAFBgKBU9lVQC+L1/jly9B+7+TYdmKhZXtTW1CtczqAdSIN2bqbFTBNNDQ490EvGrt3IxmPrP3QLqWErZOnIIWZNHNGiFIrgNrDM4k4HbypSEtMmkq5Xj2oMNADpagx0ou9Ao9ZDbwKtuS6LYAUYng9pmqUFXSnmp1UDmPSQ6jQuHyGBCuctnXcTaVhW3bC5isarBUOsQE4QWyqkL8WkgQxMuhQh7FSfu+fxo0momgR/9Fft6qMgqFb0NuABl11Fjt/psQZDfvEsHejU5CRbsUMWvHbOsO+9GLiXXNtXGunl3dkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:44:18 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:44:18 +0000
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
Subject: [PATCH v5 18/25] mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
Date: Tue,  7 Jan 2025 14:42:34 +1100
Message-ID: <8bd0a8c0f62e2d2d8ece6f445580d20b73e3decd.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8PR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b89121-f9af-4cf4-bab4-08dd2ecd9095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lFpxijuMkebbh8p0fenhtH7ApCD8KhAP4e03QGVLmxjn3wiZ7rQIm2bGmyv?=
 =?us-ascii?Q?De8Jbq1Nd7Gy5oX2eMQyxfmpvOLBwdEcqOKIRo5jIa7tp3b8km6Q+XloaBN+?=
 =?us-ascii?Q?dM+0tOx++iLaiWEx8yMMQ4WDouJc3QqbQtwzc+NAa7hZpeIHi2hGeZ15jF4V?=
 =?us-ascii?Q?3lW8YFvt/brUGMIvHE1DJP5k7Cj62UUKmUF271nsMQ8ksd5ItyJY8PNjc0ok?=
 =?us-ascii?Q?i3TQwjnxDRicE04aHU95x+9BhCM62N7xmZv18lkzEgP2+M1FzMI6Qg06X4QO?=
 =?us-ascii?Q?4hP89KQiQEp1D0WN0Zvnu96SIQwTC+9NDvJF9X+75LFedJEUoDmXoiyqJb11?=
 =?us-ascii?Q?POr6qSraCWzXPdeWL45E/x+YVAN9OK9zpMzODkzxRFAQHFDot/bLVUOx29A4?=
 =?us-ascii?Q?/4omkbaf7XLyCrylqSXn52IVt1B2oApLFExqvJngpeEmIDE2U/7Zgy+gJRN/?=
 =?us-ascii?Q?e4wh5zyd8qgj1tFsuGWwMYUCHX2Di8R5uNobxQsWahRKfzDodvnx0TOeE6uk?=
 =?us-ascii?Q?uHREnT2ZWN24BkR0BoZZMTMfvymCdhkGYHMtRLxxUF9dkzTHNAMGgAsvMhmA?=
 =?us-ascii?Q?WlvI2lTZd3F49Ui7OVVhzzwh7QOTNmNrRVT2mWpIlBKZ58Q8gdrtSS0OMXHP?=
 =?us-ascii?Q?NO/1jYn6oABZuBZE8Rz6zMN/1OJi2sYcdqk8it2Dtr9NnbMdTg07y8LKmRqz?=
 =?us-ascii?Q?s5a4cBKWqajYaZMLnXIHevouoYMoNoqxe1aH03tsjeBJCEE2tuZVXVyn80Ms?=
 =?us-ascii?Q?Ke2Uynd1HeClM5YFyOJ4Vi1UN6JV9cOMwjL7WfZDNaGUvjuxtWV3UTMFEdJo?=
 =?us-ascii?Q?wvj5jW8L4LCz0iKbitXaW4w4cT+wdOf18pOQicRgchQtt2BWyiAGLByysuwn?=
 =?us-ascii?Q?znu3IhbNzf8F7JLjoW2QdRrNZZZhKqxrhZTVCkjHxnaaKxqlHPBE3CKMgs36?=
 =?us-ascii?Q?THQFa44c3NLMKuuxCOQ/kJbH6+BXTwS3aNqktwihnY1WbvCctNloHFDfSI+l?=
 =?us-ascii?Q?bAwYKDpVSnfaH5ySUGFwLa9m/9OfdbygMZbew4KN3oB2b1QffdZUxc/LkF2C?=
 =?us-ascii?Q?aEQYJknuT5rSBQ7cyCckfCZQz9PDyrCqAbNyOrvA7de4KR6zQaS+Z2o9LXIG?=
 =?us-ascii?Q?st7oWvKDTokePRu1iuFDjdgjzkvwYmjA5OYRANfChU+GJEn+GhpMgJh4+J4/?=
 =?us-ascii?Q?pq2qEqA2bsJacdmknBbg6c75/GC4sIM+Mx9CdTyOARlXnqXaRaFmxN5R8z8W?=
 =?us-ascii?Q?2hTUJs1qTpPvoW+UXyMjefB5zFYNAt1cX/yAOCeY8u0s6wVgzwyyPVgu9L6D?=
 =?us-ascii?Q?5z2Zdcbzy70CI+/ZSTJDkLREDDiY81uTmhPilbXD8wfTUKuU/5qaxbNo0MC1?=
 =?us-ascii?Q?tEUmkzSIV8V07CUmTqjoJMiv6CID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NBqV8RDm5Vt0A8f3DThW0XqkrdXykQ7wgyT40lAfARMnj8A2p6TfurYTaa1C?=
 =?us-ascii?Q?xHIIcs8Hnk8pgJmcm99eZ+DkVDoGzPi0Ah957Ct/tCW6Nthbfxq2L0lxxVGJ?=
 =?us-ascii?Q?uRH8M2y8I9CfxUzirr99CyWwCIv6ulYEezglsZZfrqiKbFFwNioSl3MOFvwY?=
 =?us-ascii?Q?3wuBa6ZiuzsMHOqjLL6Qxh6peDyum3fIgB5tsSJjkUoFuge6OF0Zl15w4pq9?=
 =?us-ascii?Q?QG5Di1MTwYbumkYNV9K2m9499vX/yZ64NxhYgev8IFrsToeOig3CuJ+kirz8?=
 =?us-ascii?Q?A2JM8VZXkoP3GwoT6PeBAm1W/4Y6dSrkIYD5dQd/yJ2Gt3aHTnOVPkGG0MLW?=
 =?us-ascii?Q?xnPzBVMz5YO+k3186KCSyp9A0ypON3eCGK1BiBJUkqQ6qSzuOXz5jTP3DE1e?=
 =?us-ascii?Q?HlDwvv4A11SuFrN4jLTUtiPcbWsTqVQbBIKfQLfSf6Gd6vmIzbZdhSRuCbpu?=
 =?us-ascii?Q?44pr0vOzxpMoC6HMVOkQ7D0+k/pl+9uTf3GHdffvVvXsQN1ZseBp/2LbcI0P?=
 =?us-ascii?Q?l8t01xYHi1IwhRc4BaQeYHZUlN9o6q01UKyzwf+FAOgg9QyPyAqUklnnMPMs?=
 =?us-ascii?Q?59gquvm7h54raRqJbMY0IRMahue4ZazkLuq8RCbG8lLlTFqNyk3KhiViVqQH?=
 =?us-ascii?Q?JS3+kgLw8IKltzN7sfasyXoMUb0yrJNavHkVFnvsTN0/2Tz4cZKfNAH+0uyM?=
 =?us-ascii?Q?G879QP12IWie+Nzz1a6ihFycE39YIzCtX5T07gONJMgBtyf0r7Ouyx3Qmmzo?=
 =?us-ascii?Q?/LKyXaziIUMCu/XiB1jw/uPvPwFvroEwUb2MR9QacngdWpy0TJgeobsW8u9v?=
 =?us-ascii?Q?/o51bHkheLN0o+xROmUReyM40TwXJKYduT3+ROsV4TfYcKlec7wgVylc9E8M?=
 =?us-ascii?Q?K052b1gR4bKY5/HQWVI50KGI5SWHsI2hl5dXkjtlJXD+8DzKbm7NgxMdauEC?=
 =?us-ascii?Q?BMI2QpKHQ/mU7bsRGse2wM4RWMQI9+WRPsvW9CcIjdTY8EZh+JZcupMt1qZa?=
 =?us-ascii?Q?rLq36RoSQQ7QFCrkdQHAej94cdyePyJSLEBi18KhTfgNRZBWsTxkXdkghmxU?=
 =?us-ascii?Q?9WlomVlKjwhv2Zc0vMRWQgPlquS8ty1wGun1PwbUSDg5T06HPYsT2l0Ns2AO?=
 =?us-ascii?Q?bh3q+cfN/A+gB6gbloIkowJo5DTQU+tX63fJpiqVlqb0RA4uEQJgSidqOVfB?=
 =?us-ascii?Q?IIrCQKADZBIl9DnYZMFN6MF2xNGCdqY17YjFi5Atfd/3Nxoy19bKFZSO3b2X?=
 =?us-ascii?Q?VKqvQlSLW/JU8EouTDGyLtGv8h1AXycApEirj7CklqTCW4oeLOdxJWcOue1W?=
 =?us-ascii?Q?rF61nfgpohM0fKLCGN9MhMi/8epLcjyJXTiaVhT9/Cv1HzK08arovXjTEQvU?=
 =?us-ascii?Q?nkFnRqSdl3KpFWWJar5Jy/gPh853HnrKA3UyMZ0RhEVzIwtORFM0Tew++kXo?=
 =?us-ascii?Q?Buehc7eaBSl2DHKs+geaXAgDQWZJJkGITNvB2jGq2eUGqRiS67hZWvzLWqEB?=
 =?us-ascii?Q?BVu38lJJg0odRxmMcSiNvj3C3LBrbNNOGtg5Y/IJB/TQidWfJq4IDgo8xBk/?=
 =?us-ascii?Q?DszMvQ8a8FiKSfo3TFE7xDS4KbrGlG2R4u9SX2Xb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b89121-f9af-4cf4-bab4-08dd2ecd9095
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:44:18.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBt6QiCUUhNmcW9ZPZpKiA3s4A2bDWPeBBk02qP62I+Kb9+BE9CQQkiCn+eob9beK8p1KeAoWcUGPwtqrK2dwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Longterm pinning of FS DAX pages should already be disallowed by
various pXX_devmap checks. However a future change will cause these
checks to be invalid for FS DAX pages so make
folio_is_longterm_pinnable() return false for FS DAX pages.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f267b06..01edca9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2078,6 +2078,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_device_coherent(folio))
 		return false;
 
+	/* DAX must also always allow eviction. */
+	if (folio_is_fsdax(folio))
+		return false;
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
-- 
git-series 0.9.1

