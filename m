Return-Path: <linux-fsdevel+bounces-38811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD7A08758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A649D167409
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0E208965;
	Fri, 10 Jan 2025 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zftjb0T2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1D2080F0;
	Fri, 10 Jan 2025 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488913; cv=fail; b=Zw/xJ3r/n8ATU9tpEZ0ZzSQ83ZRM1Eyg4KZ80yy5cUhFJSrtY4bo1FAEQYG4jnghy8zSec9Hhv20JTaFogCEt3MJh1eD3+2u8Z7TiPGCIPsW2ri2uYEmN+sAOzR3Oa5jxYZBCyzaJIK57QrSt4t4fu8+HsSRnqfhuGYZCm7KdwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488913; c=relaxed/simple;
	bh=uoojXR9pMiDTqYvhQlYMSKt7WxtPNzAA4RZQbIPGYZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZPsDxsEmaRzBxd3rnWAbskrgteUiBKUVKZ3fd9OWHQs7FDxXahgGNML0w1snoN7yvPWusBM2f1nnC7o/ariqjLtZu39hnoOqbHHJfCz3Bm3PxStrW71nF2CtsSRfpcUjaez+4VWcQZb0sLNwBsu8uKbPlR9RmZiLkRiSNqUOew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zftjb0T2; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RShinaHeDG4Bga04upMbaNk5BC6UZG6DKQudF1L4IpZ6BWfOaEpEG9hMgU520UEe/fhU6yR2JX+s8llO/JcY6OLsrO4eekNB5Wvq4NcU5IXi1Aln6sO6ktyteTvaR1RREuUEtMfi6kt7mpB8mSFqziAK7WnmDqNwaK7FRyf/U3WCBxw2Rde9LpjKoocDNZWNHf6U7rewCcQ9bEiPm4n3OpTeFJeJ0WLztjzhqrWPfhqMvYnZlEzbNDMOPS9qkYpw5JG6l/GhBZBgtwi2Dzmr1fzaysooG2XfM9bWrK4rXfXqGLyNnZPvnLJ9012AdNM25VQITj4b+7Yf0L+39SI8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER7K2Nhto+D2H0SOiC7s5XoVP7YNBHuv47QT2yu6LUc=;
 b=ssskHnEbnP+yXDOJeKYsRTQMDtC7hAMEQk8rMwx4DuzHB+wRr7+DexckYfY4t7Xz+RfcMuWVNuyf/Wz/lN940OtsXlWTCtk1IyPs32FdghJx1rgrYbFnpwWJ1Ks6PhzDC8kkq96SZrM0XPrumXFwmRT/DN8gCXhQpP5xALFliJXSny+O/F06LIzHpBOIq4A82mq2iRAZgh8tgME0SrByYywuMrlCYxNsXJmF8Wj3RWjqo+OLkT+Ii5/EeQvB9OUNy8Y1eHI90ZNNgOA8Yp/+/fYdKFcjjipa4oRFMjP8uo1PdGtbSS9oV1rcbQxQjAbqnUjGBTcYJ+KCx4drSciJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER7K2Nhto+D2H0SOiC7s5XoVP7YNBHuv47QT2yu6LUc=;
 b=Zftjb0T2v5j8vvDRQsXLrKDBV1RC/iD4yxVamXq026+GVedNnw9dL5Uo9C8pGeaUVacdNtPX2X90IKlubEJ83HhnoSBMobC8xs1NGXp7flF776ubVdZYR4cLetj7P5nzfNdSzAlHXeEOjGj8Tm0sdkPKXYKOX/kMZfwWxvYxI6NhTEKyaY8mQFal+lEBsZpCJqtsDc7Ocxgz+Yfk1C1uv6fCf0hvxlJReNzExBTvuCBzmWBzXV1RPNxoYf16rfVVJdrB+hRsTLeLfyOZ4aQadCtfiSrhvOmADQTdFUzzpSaFNeM7vtO2K5G/6TATEWGfhXLOO5noY3R2b8zWpYjRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:01:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:01:48 +0000
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
Subject: [PATCH v6 05/26] fs/dax: Create a common implementation to break DAX layouts
Date: Fri, 10 Jan 2025 17:00:33 +1100
Message-ID: <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0163.ausprd01.prod.outlook.com
 (2603:10c6:10:d::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 76505c87-9382-4ac7-ba52-08dd313c44f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uM5pQYzbhbY+80R10esDSyQXswBuJhDj12CiWj2UuxxhB8KHuM0p1uh2ZtGY?=
 =?us-ascii?Q?NscgHcuPYhVfdaeJz/GMO09rRpHjqqICqmdobKICOmG6bO5hReLb4YMH3snG?=
 =?us-ascii?Q?EZFp6J7q4/OlLTYAunbvU5zJ+aYD5OS1UJhp6vOf4b4oKmk7vmUt79VH7bYC?=
 =?us-ascii?Q?X7+NNZFD1QmPcO/wfoSKUdct8m6oxoZxnO8P0Q8tjbLKyobY5lNxyTbFMh75?=
 =?us-ascii?Q?M1dV/AH7Xbn2Q5q74bPRQS+1NrZk0hCZYu23Ps1VnkCsgPCYKc6uxqSXnU7R?=
 =?us-ascii?Q?Gss+QKCIgeWMZtgMLBGQR8qXx9zq8HUZBWTa5Q8FlgBwqgRcZ7zUU+eiEup6?=
 =?us-ascii?Q?d/0wL7sGSR4OUVPzmaDN1BtA3nNcMryF3VOY78lcCp3JYk+EeYTntaho4ZZE?=
 =?us-ascii?Q?1CHIJxyluX33F/kfFNHqD5GeqJAwRfBVyDkx1C7F5WJ+L35Pc7nC1ODVsyfe?=
 =?us-ascii?Q?Ov1W5T6ACiv51BhwE4nQ5vvcqAwjre1d2TOir1a/Ew5oz6CNtgztFWu+rHM0?=
 =?us-ascii?Q?hgbtNeSK4t92xd1Ycgtn7ur9dNrYSEBrR/qBOAHk9j28LN6O9+XOnos0OCej?=
 =?us-ascii?Q?RUP5qFLHzcMxFeI+d5/0p5CM0Ey7kshV3HIqanyYP90nY6C0RV8WD9K5MjIH?=
 =?us-ascii?Q?ZhZ39YCaBfC0Ksfyfg26CLVp1J6CR3kR6DVup8jwbftrQTHT32W5si9OLhaR?=
 =?us-ascii?Q?rZ4yrg1haz2yEK/eEM2MHUYx/fr+LD0XazHpTHfX2w2Uv7iNo3fInZvVwbUQ?=
 =?us-ascii?Q?fY88RRDQhJ+d7st2mYpGNUQQnNQMSGKbvdIRwrQjBuNyCPiRt4OeqGKve00c?=
 =?us-ascii?Q?vJgOKO82Q9FK00UtYTsH6Fz6rN7npMSqlW3KaqvhGZ6QpDzA183AyJWBAPSS?=
 =?us-ascii?Q?Mn8T8fGaeyN8Z927IMJW3MLFFAetVbgtI6av+v29dQUmJurQGhLzAmRp8hSo?=
 =?us-ascii?Q?DNyYrBcsVFXX1V7W2ma/Kj87eK1+LlT+pqd+eJtahA4gwc8RZOXTIFcFR6TF?=
 =?us-ascii?Q?ZrZSYEzqI7FqK4NupAUbt/R0S9yID8qB+g7htlMtdyT9XSCFDb7WJ6Ck764B?=
 =?us-ascii?Q?zhaEO0dOph2gR1gVRf2dGC9hxjD8i6cI+Jh8flrNws3GtaNpp0nbpoWG+qHr?=
 =?us-ascii?Q?yGF7knb16Txjw+ouv6h0MekxRuIuvGISD3gwsCFLsjL4aT1aBsmn4Shp2lXz?=
 =?us-ascii?Q?m+7veb5mbbwcwJySTRyiM0m5fvWqf6FxhAidsSaqcPpQmrgRSrfxhtlSO0CQ?=
 =?us-ascii?Q?9oPnGjKV5fdBXS2QkJNREatWM1P4C2KOaluE4MM5EcPSuiWpLKV5bT1lwSDK?=
 =?us-ascii?Q?n0MYNbmyQcdZlOwGPqbfdF0CcxbAHqoWsud7rt9KMNojkU/dnBWyLPXUfI+j?=
 =?us-ascii?Q?8U3X0orTYbJI8XCXm170lnnL1yIn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKaYFMG/wFT/42roKbLFbbxiT6ODCtwOTEg+f3bOO1FnJ9B1WG4EXN4lLZCj?=
 =?us-ascii?Q?lPEjf5FIm7NFUMG/3j9tNHVCMtnNA+ClcdR0GELyuxZZeJ6ospnlxDiO3+v9?=
 =?us-ascii?Q?91Kab8MkNVj4KR5EHPfq2ia1yt5Dn6cnxLGGumgYPzzWudc/NUzcmwGsPiA8?=
 =?us-ascii?Q?LTI1Hou3YRCsP3bNoGASab3sXm72oH8uddffXcL9wCn8CfFQhl+6poWMpfg5?=
 =?us-ascii?Q?FzB0hTKVEslH5RC8CpYaa/yZnN2uFP6NAv+5kmd1WVXCWE2Woj3SL6SjnCdY?=
 =?us-ascii?Q?jlWX/+M8SqPBrsnafvhBWFtGTM5UU0CEdDqHPX1Sh664Q72wtlguIXIy8z6G?=
 =?us-ascii?Q?k2iarRm7ow8SDsqd5UeeQXOoIUTkByMYXxpGPfxiZdwIDksa8cvV+8/ISdfR?=
 =?us-ascii?Q?eq+ZL4JnDgs9H7TF1zo6cuVyr+PqHdjJqcaBSfhtha7td3ZFVF7+BZNSgzzC?=
 =?us-ascii?Q?v4w9+WX8+LQcYL6BDanP6cF8366UB+Bcn+m2Z2WlY4E6h0/NFiOZ4SiqS5Es?=
 =?us-ascii?Q?KykbC+Af0W6UuCF6dpcDd+11kHQgfa2CJD1fqAu08vXDVCBD08UfN0bTF+21?=
 =?us-ascii?Q?JqOyFNhUVlTceZTOz/Yt0H0N8VJFYevNRlLAdGHVwvzhZEcGTNq8+PHhpzIb?=
 =?us-ascii?Q?EFtOO1sJK+DS61/Bt9BSVjHIVGdVZgftNCIlMNlXbr1DqZKJXP6gQdeEOPoO?=
 =?us-ascii?Q?P4+PNaJ+EuPG7Kj3O9xDoZ8gEYC9Vxh+41bBhgAnQwwd7Md9L+5fO1SKgOIQ?=
 =?us-ascii?Q?auAGllOBVFV/FJUJXoIJJ3m8JJKM0HKaqbbdUlO4OPwIbk04SdKn75e3Xw6X?=
 =?us-ascii?Q?uHjvvB7MtYeDOvJoLCxsO4hsyF5BQGuSTl2N2gnL4L3Z7W9faOi6HVWRPTkE?=
 =?us-ascii?Q?RDi1ZMTzzNI+IG0+SoSf00a1nFD+hSaOn06EiDXb14ZOoToJzOXuDxCbhUXS?=
 =?us-ascii?Q?8sq0RbeIDrdpIt3rm1HbkY9wEaUYh9IzDkm2DK7mLI+/virgfsrL13U+zDTz?=
 =?us-ascii?Q?1ed52t6gFPESiT2cnJpQWzAvh8Kx1e0cigAz5C0HPAcE9wXfcS41c4s1Tzhc?=
 =?us-ascii?Q?/PvlbtH/D7uAyQybOXTBBGRz/1YoAzo86Zl6aGXZfMM+eiU0n8SAKabSYPmX?=
 =?us-ascii?Q?uJBUe13Mgq8ObYvqRRZIO7hp4wSFJCMjX8HgsTamSigHw2uClz7zQN9w4wIx?=
 =?us-ascii?Q?030B+a2j0LKMDpdXU6+gJEbHQwc4OTaIOvvriWD6RLtWezRowh7n1+MAHRMr?=
 =?us-ascii?Q?30tGW+ZNgbgI1sctFm1Fr4xkM3cFolRFGEy9uZyz8z04iWC9c0TcH3w7YCaf?=
 =?us-ascii?Q?IskIdXaTUhy6POwC2BMjSLIZSx8ivjaSTCxmVHmn++qnrow9uDVEBxmjkO/x?=
 =?us-ascii?Q?d2aEMu7xk4IJvYptOXRT2No2YX/XYK2j3XJBlj576l30T5Mt0bPrnwU1x6og?=
 =?us-ascii?Q?15REXmKdzShqoOPcMyTF9s8tdLbksyvnRZyWEmW/DJB/z7griFXszOq4DnB0?=
 =?us-ascii?Q?E/FXr/x6Fnv5UNVLEcMtIP2nc13VqUJBpX2LI+2gdU3cdXtvGlkTEIHLOxEH?=
 =?us-ascii?Q?LoZHljzR8dhGcE8mnWaBSYafwru/zT4QdrlTXOxB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76505c87-9382-4ac7-ba52-08dd313c44f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:01:48.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OIPNuqtszCnBr1q728+/3jcX3TqrNBJxBlZ6GCkRpjRAzxMiE3XtCE5hJDGU8h8atZhu70WH5Vn3D31XZ1NZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Prior to freeing a block file systems supporting FS DAX must check
that the associated pages are both unmapped from user-space and not
undergoing DMA or other access from eg. get_user_pages(). This is
achieved by unmapping the file range and scanning the FS DAX
page-cache to see if any pages within the mapping have an elevated
refcount.

This is done using two functions - dax_layout_busy_page_range() which
returns a page to wait for the refcount to become idle on. Rather than
open-code this introduce a common implementation to both unmap and
wait for the page to become idle.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:

 - Don't wait for idle pages on non-DAX mappings

Changes for v4:

 - Fixed some build breakage due to missing symbol exports reported by
   John Hubbard (thanks!).
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 10 +---------
 fs/fuse/dax.c       | 27 +++------------------------
 fs/xfs/xfs_inode.c  | 23 +++++------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h | 21 +++++++++++++++++++++
 mm/madvise.c        |  8 ++++----
 7 files changed, 68 insertions(+), 56 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d010c10..9c3bd07 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error;
+
+	if (!dax_mapping(inode->i_mapping))
+		return 0;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+		if (!page)
+			break;
+
+		error = wait_page_idle(page, cb, inode);
+	} while (error == 0);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dax_break_mapping);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cc1acb1..ee8e83f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3917,15 +3917,7 @@ int ext4_break_layouts(struct inode *inode)
 	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
-	do {
-		page = dax_layout_busy_page(inode->i_mapping);
-		if (!page)
-			return 0;
-
-		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
-	} while (error == 0);
-
-	return error;
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d2ff482..410af88 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -665,33 +665,12 @@ static void fuse_wait_dax_page(struct inode *inode)
 	filemap_invalidate_lock(inode->i_mapping);
 }
 
-/* Should be called with mapping->invalidate_lock held exclusively */
-static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
-				    loff_t start, loff_t end)
-{
-	struct page *page;
-
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
-}
-
+/* Should be called with mapping->invalidate_lock held exclusively. */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
-	bool	retry;
-	int	ret;
-
-	do {
-		retry = false;
-		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
-					       dmap_end);
-	} while (ret == 0 && retry);
-
-	return ret;
+	return dax_break_mapping(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 42ea203..295730a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2715,21 +2715,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	bool			retry;
 	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
 
 again:
-	retry = false;
 	/* Lock the first inode */
 	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
-	if (error || retry) {
+	error = xfs_break_dax_layouts(VFS_I(ip1));
+	if (error) {
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
-		if (error == 0 && retry)
-			goto again;
 		return error;
 	}
 
@@ -2988,19 +2984,11 @@ xfs_wait_dax_page(
 
 int
 xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
+	struct inode		*inode)
 {
-	struct page		*page;
-
 	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
+	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3018,8 +3006,7 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			if (xfs_break_dax_layouts(inode))
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1648dc5..c4f03f6 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -593,7 +593,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9b1ce98..f6583d3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -228,6 +228,20 @@ static inline void dax_read_unlock(int id)
 {
 }
 #endif /* CONFIG_DAX */
+
+#if !IS_ENABLED(CONFIG_FS_DAX)
+static inline int __must_check dax_break_mapping(struct inode *inode,
+			    loff_t start, loff_t end, void (cb)(struct inode *))
+{
+	return 0;
+}
+
+static inline void dax_break_mapping_uninterruptible(struct inode *inode,
+						void (cb)(struct inode *))
+{
+}
+#endif
+
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
@@ -251,6 +265,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_mapping(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_mapping_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
diff --git a/mm/madvise.c b/mm/madvise.c
index 49f3a75..1f4c99e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1063,7 +1063,7 @@ static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pud_trans_huge(pudval) || pud_devmap(pudval);
+	return pud_trans_huge(pudval);
 }
 
 static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -1072,7 +1072,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
+	return pmd_trans_huge(pmdval);
 }
 
 static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
@@ -1183,7 +1183,7 @@ static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_trans_huge(pudval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
@@ -1195,7 +1195,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+	if (pmd_trans_huge(pmdval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
-- 
git-series 0.9.1

