Return-Path: <linux-fsdevel+bounces-41927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50301A391E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5217A3D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E91DE3C0;
	Tue, 18 Feb 2025 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PsFAQY+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129C1DE3AE;
	Tue, 18 Feb 2025 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851049; cv=fail; b=Uht1S388fsqfyr2cALMQE50lwr5SwG+Bqr0QJSSkGh9oagbGr1a/03msfr/1tBYrHgBRJLyIuUbqG4P1BxAFRnlC0yS2OR05n2YjVH0I9cOmC90MEE7yaDoa/VQuhAoJHioGImrSSBkwm0l/NnYJcjJ98R3lrSor98F4wKs/29o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851049; c=relaxed/simple;
	bh=0OyNXO1+lCFhiTVcK+8x0NuTlGOxtzcFv9cygOWTmMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivUD4os8esvMxThrmzhpMusc4ez69212GJlYdURuKt4gjzfREE+OeGCjPLLKgQp+MLJ5/ymWEBwNmO/KF6GghlPHubkfIMPUAr87hR2Yejq+VnDmH5+TQeX7TilBeqqoc/ZjlyIvMEd3NvYZYJqtfmmL+qgCHK03iIB6nZ8cTeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PsFAQY+U; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0JMNz6nM1+LJRi2GdyGpE8rYrj/aKHWgLLtlLasdWoox/86no7Brf2Y/PSlDO8csNxHlWukeXZyXl2ucJXQkcEvkaAj0K//NQsBvYx06RTkkzvYYppqrf+Pye9BuUub1wWiIoX0gGErp3Sy6azX5h2Hh9VAClg6NEjXQjgLTAFHkcBXPRlqDYE/+YTLBsQgL9IcpJuOmZEJV8hvA+zUuTApThxfj06YpRXgK8DWGhgsuCR0rRyjnthkWmTnrhWSbfsuq52EY6D6Hm1NvUncA+mgF84RXPXUfbghjSdCxIJC4DFb12wTwVLuOK/EkiiQiW2Mw2HQDlhlqGJApPGicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VENjcw892hS6S6Ehnh8sjwSOcKFsy/z5WoqOWPzB/Kc=;
 b=lOKenUJz0RumIR1kmtb484o0agXCnV3RZOP3t0HGeyvxk+/rqJLClfSeLa1SIfv1E9nMl1GRMfJ8/hJ6Z2oGpYyD5i2TyZxRwmX17WkPWNfZi+x45GbcuChWl4pYJEixGNrpH9eh0eVb1eFlYJ6pyP74g3/FtC98QPjAvET1qWO7y3yntvbHlYaLvG0GzbZbVXJn37+tZ0tNSn75XRyzcVhQknlN0T5I9D7v7ruPmo5UHe/D0Sx0HRQtTQy1QuTh0CDkXivqCH1PvzoLbvnSQ6NekBaV4wns0QAasXAB6Fw+yyvhBAQSK7q8WPqDAqQ0TgIx4GPHRUSbt8paFltwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENjcw892hS6S6Ehnh8sjwSOcKFsy/z5WoqOWPzB/Kc=;
 b=PsFAQY+UmmHvg+C968klRHvK0jg6L3RU/fID07uMQ17GLQHGphQK80XisDQVb14Z3P6CL7W2KYRkbkgHbAdWf0gkC9fXZc4H419UuXI3UV8qX1SRRyhEvUvStmmmP4lB+a7DsE66yrQVLd155gfgfCaWW5TqYlSBuIbVuy7F+R36qh/h6wh677z0bH8SWU3Z+22TbkZJYiJ7NP6Kq8mGdPhgXw0sX+CCe1afDSW2xBlOeu2+7aReEyXRH4YeS+hzonf2wQAIu4ILE3h9SHU6c0GZW+a2k1q0q8tMNM1t/ead/NJp7v66ZseF4IfA9NVOlzU0aZ6DwJcbTgPjzLXivw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:20 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:20 +0000
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
Subject: [PATCH v8 17/20] mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
Date: Tue, 18 Feb 2025 14:55:33 +1100
Message-ID: <9cc175f877358da2fcf1b2b769030d457c16c5dc.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0158.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: ba988643-06b8-4cea-a580-08dd4fd0580b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aLv4yCLz2bzH0/2XPEileWU1UF5G3LQntK8G8TQ3jvJrKdyYsNXq7ydVgHu?=
 =?us-ascii?Q?u3yd+d/KBUYZz0XTn3AdwKLEjPYxhGUZ5vuiIu6ALFnW418n1plC1h/SseYP?=
 =?us-ascii?Q?qrXgKCJ9N3wUQ+UTe9AOQ4fDbHPNUhPfzP0Di1b/jH1R/pZ8z0M1SKWIpyN0?=
 =?us-ascii?Q?qDO+id3mDf39uYzU/qBViXwQXAunUAY4b8fyidLXdOdERoG7q68Y8l2QZvQJ?=
 =?us-ascii?Q?Dyt/FTv1gw/z/f6CiGg5AZG20nS5RVg23RiF9qWJSQnQXihHIbMuV1THXDIN?=
 =?us-ascii?Q?hr1cPQ9jkoOq/walCSxzbqDth3udeecTD/msDpO+m4Z649dwLPItO6arFwep?=
 =?us-ascii?Q?+OrvZkWNXxkXBRybtM/vhiK1RNZBVnG63TlkVQzwQEOiZUFcxbjTS2RyUZON?=
 =?us-ascii?Q?mMH2UbsT4h4P9R7WKImQHsASkDe0pxDepTayZuIyyiiBc5Wpo0P63deKsaS6?=
 =?us-ascii?Q?VXfbGmoYvKQjk8KPi9yasLl8df1SkeivjlJZ+O/W6X2JxW/mz5uKCnL5l2Mc?=
 =?us-ascii?Q?2vOM5vGup3T4so0DQ4bKzIf9Goxvnzqjqxy8KtvjBhmNS/Bwq/d7+MJalUsL?=
 =?us-ascii?Q?KOib/ttHRu5xI4i+3p72MGAm3PDb++qhrX9fcf2V0eb/bFbzz+4g/RcMFBHH?=
 =?us-ascii?Q?FNuDGqpyKTTD3STl09vg6ASBNeL5zCdI7cIugq3yZInYeKm3x34U7t/7XRhb?=
 =?us-ascii?Q?RuxjGN7P9tkJ+MBgCW6JDxfYMxjKHFTEMNMSxi+ZA/MFmekROSGg9i828oxI?=
 =?us-ascii?Q?njotiNsAkh2TCIR1e2IVeFur5rExg2sheanZsm1Lhs36vsJGd0GO4+fzp5De?=
 =?us-ascii?Q?CzYDAqv068VwlGaY0oJosc0HSQeui/Zr5ObH6VoqcqDCLDvU6F8JkWae5AC+?=
 =?us-ascii?Q?fzQ68ZcKb+fA+sZYxwZCk8ynbVtoXzBjfOAgJC4Zn5FZFdB8XS0rJzio/7a9?=
 =?us-ascii?Q?7AeVGKo5DM9h3D3tCV0Ozam1F39ktk21GCDfj2XSUAwU5p1hZGZQfXQLpddZ?=
 =?us-ascii?Q?GASAtIsPoDoaKTvUwLPoU9oZWdZR4FK/aZzO4iq9QkkhI3lb7c4kT0HoE3q0?=
 =?us-ascii?Q?fmoNvYuf/Y5GS3QGE1JmKHQh3FGG8EBE7oSr2A2X0ueQPnkfu8um8gHPr7ob?=
 =?us-ascii?Q?sNxG72fmhs0gywg+oc3ZGX0XnKrTYubAhAQ+KiEOP56uIYyYzsy9cGfU2l+n?=
 =?us-ascii?Q?yVwDlnHIu2F8wrziuP/CcKio4fk5i6qJZQfqOyeoiwEoqbVc7yg9q+PGmLuj?=
 =?us-ascii?Q?wlUFjURoxMEQq7PB5AVPoQXZYt+EINJuEImTLg1tCm8z+lfscfaOwDszyoFb?=
 =?us-ascii?Q?qotQGsq5unlVVkkkCFHwVMKnsEk6H76iSqrmG7S/SI8tPFQgXM57IwNv9eA1?=
 =?us-ascii?Q?KVp2txSM4Af8dw2CFvB3URM6x+GK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?78ezF8xB1qAbdsZ57PepyzZFnn67AHx99HmY0SC/LFOfIRT4DOSvwYQAiZnf?=
 =?us-ascii?Q?8i/KF9rnNA5OwxIvEbOQZiyXgHLxUT9D5mEoJKf0gAK0LH12ceTYHVbCF4IQ?=
 =?us-ascii?Q?AqfJWcA23R2s/eFZyHOV13Zp1W2bvTaoj8j8+jkzgqJM47vTLAZgcbF82zcG?=
 =?us-ascii?Q?3VBeRfN8jf2b/VjDmXnYNz/M/e3x6MVyaHjs6hSK3FS4q/NlNuOeOrG6azII?=
 =?us-ascii?Q?CpsUzNvckWXSebgCtfA6iNNo/6LiXAeZKk1ju5nrq75WpKD/3/SeGJXFP5qj?=
 =?us-ascii?Q?Ny8tQrDhdCohf/7OOWm2GevvvnzzU1bLC9TKIdN7AL4d8trVYNQv6ChFZ/NZ?=
 =?us-ascii?Q?fRMgKj+ItJCQxfCWhFnlNBJnCvRwmN/nJeCvCYAUj0fMyHVYoJfdchh+R6xz?=
 =?us-ascii?Q?WEe0SDGKcGJp0QvorVr/BE8Cp0Tl63M+ebTdogSWBQtOYoVNJ5K8/SaBb2WX?=
 =?us-ascii?Q?j75oLlquDF/9VqeEAII1YW7MhBZ+Do6i2WV6CMpmgRd4b21mHW12cHT4yMLq?=
 =?us-ascii?Q?E+ZxMBFNuJXuHzioRtL/jdxLGQ978wI4npS+gYxtN4E6qwewtf6xtCW/jHcN?=
 =?us-ascii?Q?iEWUXxKPyH2UvWJnSKqDCsX2MMneylBB7H0p5cuUpxBCm3ls+Cv3fB4NYU7i?=
 =?us-ascii?Q?3CFRnDFs4bHOM/2HhHomwIiFcRCvfUTVSRUplAx8mQ3nCTv6E2QonNbxIApb?=
 =?us-ascii?Q?rnss1ZdLHWuS0HmNDnPpuIBnnFfCW0gYOe2qnAH/1w9WEj7IGC8Ppy90KlyX?=
 =?us-ascii?Q?SDtIfOzm2BYAKzfI+P7xdvHBItY3J2OwmSkuYf0n+ESpxLxAOvbeHNf+YcFf?=
 =?us-ascii?Q?++K39xGwdNrYW1B+SO99nQj8SPjlYrYxsAVxdpsR3rlHT6ojDQ9BduJmKXmd?=
 =?us-ascii?Q?dTkIeRMn0LQT0ud0a9dlDXJoGbTc56crzmDKjwCZKer8RlbcUhMNFD8gTl2W?=
 =?us-ascii?Q?t0O8CtMlwG18DlYeKvH1MN8Tkj4UIb9Qf27cb3paZui0yXrS3hs+aYWaB8U7?=
 =?us-ascii?Q?/fZwFT/Vh4jwnp7GwZYWNCwFQ27JDubve7i/wKUF37DTrVgD+WaoClFR2Iaa?=
 =?us-ascii?Q?IGjGdsZKQzoNrZpbe89fHHIh64AD/Qc7kF3kUAvP7V3f/JwM+gf8+iuMSnJ0?=
 =?us-ascii?Q?xxiGhF7XOMG/JPttMgykwEf+amJsb8Cf2g1Nn6kI4JqlpgNohK6EyPISZfWS?=
 =?us-ascii?Q?Owc28RCzxiuQMxTSPWKYYqRDnRtRC0Gdmgw3MVCQ0/2Ql3BmuLucgfkRZIas?=
 =?us-ascii?Q?uF+ph/1gMBH3iCcFXRbyQrDJumbM0yCxgeLstjsev2ZebwuFiBx3KF1WHBDH?=
 =?us-ascii?Q?gdz/mB0Zjfxmh5Jh6N8ERd2tbv84JASqyW6Y3Thp9+BgJ3ZrUEJBFQsnOvML?=
 =?us-ascii?Q?SDiJuH9IG8YUUq5FD/xub3u1J6HKO+58Gg2/Fq2whRPKdibwm054JXrSUiMZ?=
 =?us-ascii?Q?sdFjrJ8orVk65wHi2AU1CjVYATjwoq+wXSRTgT6SJOhSdxDaxSFZ4F6eEBlf?=
 =?us-ascii?Q?knJlbbu0qlQDYNebO3CfCYBgoJs5PNdyohTetPJRZyn4LmXnu/rvXLR0yUNd?=
 =?us-ascii?Q?24PWq8He12ioGgeE4iS8uHkYbBPaW30cUjJrfc65?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba988643-06b8-4cea-a580-08dd4fd0580b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:20.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOQlpp3/9Y35FBNRUJ39N6zZcKN6+61qJMZYaVb+d4rJEcxcCCmcGtPwyMFzYI944mpOHtwrWmSf6rRqPqsvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

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

