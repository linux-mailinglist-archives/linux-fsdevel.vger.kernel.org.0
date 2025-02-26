Return-Path: <linux-fsdevel+bounces-42727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308FA46D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F833AC22E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D4125B660;
	Wed, 26 Feb 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSamyKXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C625742A;
	Wed, 26 Feb 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604144; cv=fail; b=bUIjQfITRgD70C147llnhTqloV170QdPUcMzy9U0KG8uXIPkaSEdR2YkSzA/a+RAcubFdaIP9XbZjFhDaYAG5hzTIeK17zEERhkUuYptymNSuPfgR3cfN2FVyJ1/e1kwWmVFPSRzOepbw2UEquxEuoaRu9U9aog+2Pk+OhoHoYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604144; c=relaxed/simple;
	bh=tlm2VNS1EKfhhTqc7giLlVer/ws1SPEtt8uKbdQnKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfeaZzzyuU6nxSsd7GZ57n75W6aCTj6SwcoLy3CWFlSK+1ZypBnmApX4kqekPleEQEsJl1eqxR1dnvaS4iorOtgW1xsO1LczJ7t0Qs9lZzY5Egy5HoAdsD7m6/CVKVkvHKbvjG2CUZzM4/XT14ydcdQHZRl5rh7koX9Yb9jYyws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSamyKXN; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSs8FkFzh9wqoJ2bz6eT9sd37vEFPP8JEASxTvdVW7Iu/ydpd5OP0j9jW4sTRPiCbdnHn6NT9uShHcx/ebXX0JWXBkTtpiu63Hy3IRVu65QJHis+ETf3I+gbJJLX7WlADkcAwkbYSS60OYXjWKrRz/6fSaMWGha/IyWQVpLu3L/QAg5LOubHE4db+IwAip2g2G7AJ/ziRgC7wAvINkn7ZJV6Vm9ILwvad61y1wPc7ELhDVtShX66nzMjufKpNETqmu4cg5nVcmJ49l6jCryA5byIZ9ZAKHKl3Y3S27NESJyM4wJRkWXecJBzuyeQuZ0UfM1ELuISEziXzF31jK1GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QqGevh41/tC3V+T2ChKF52ncLDVut8qgSqk7CzqYxg=;
 b=G6LlY+za9Cr8Mc999SHTbddlJGnNVQWOA36CDxmjSXBgcDk3ooBGQzMCD7dm+4NIkJlLhmwbar8pvy9BNnNw0U5PpflYouXI4zmuhtFQdZ1D61R0tQuKHRpuTKeofOVB73C2ejHvCcob0noM1IJRSKSY8IVs+fLpMlIUoIY9N0OjT2NeluiqLIC1UL/0wrQ5x7N40FvVCGm0nAT+WczXFEEaDOkllw3bSTIJUhmlXEmzzG7LkGx4Tx+ivYe4RyNzA59jrQ4dhi5mTc+fAhMURDgBKy5L5mG43XuOA0q6b+9iual8xAg3RS1ZnzSojx19HcRdryivwyYAvYp02n/Fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QqGevh41/tC3V+T2ChKF52ncLDVut8qgSqk7CzqYxg=;
 b=iSamyKXNsbx10zig6Z1AYEJuqsls/aCp9b1riCo5TXqTrPp13rulSdNb3DeIKEwRQ1MJzq3fDps9zLIkHIxLR65Eg2/BDld6/qjEwTkCq1WPmNmo+Nw6QakrYiFvaOho9yxNx4vgZWq4JUbHmedmCuXqiugbA8oHo3nPv6pd9w85DLPIIvzmk+JNoPd9InP0zL6SJwtN/LcMPNn2eLRrqdAYFrbgigX+IqJwx8KorxseyyJ8wTtmorRnZ5oglSnwaDHPv0PFoah4y0C6bjjdgFvYenvOFiC8L9+sBUnU7rVA73Pr2MuSQ/EVwduMHrRNXCKNnqS9w8K7Eq9Sg10FHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 21:08:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:08:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v3 1/2] mm/filemap: use xas_try_split() in __filemap_add_folio()
Date: Wed, 26 Feb 2025 16:08:53 -0500
Message-ID: <20250226210854.2045816-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210854.2045816-1-ziy@nvidia.com>
References: <20250226210854.2045816-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cebf45-10c6-44ee-1896-08dd56a9c9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Xp1VGrxgI/mBcNCel6SzLdW/odQZvizBGyEr0O7+j/B2oefxtEYhwbm7ToQ?=
 =?us-ascii?Q?O2DdEPw0IGwedcvxzxU1HlRiyCsHgEWTWcd8l4UddvF5K9r7c8ZPb9AJh0sy?=
 =?us-ascii?Q?wssaKCm/FXdLLfQ5oC0OFxwFY0pq6NPgKGbPAk4Zq0vZ/ocxWPc7GJ929bFP?=
 =?us-ascii?Q?FK+eG2Wlr5X1v2doxSwCj+zkHtxcptBqCFSTre/T7S2V/DTQitPBPILW3InN?=
 =?us-ascii?Q?NbZjHJAdeTlY2O3doIPm0IqVSK69ppFuVjHu93Bus4/npA9i57oLUKW5j2O7?=
 =?us-ascii?Q?3xTvMc4mM4u1RNKj4WdFuYOX7m2Qt4AjzBZ9T3FgajofNyCZCoN8FIGa2WmL?=
 =?us-ascii?Q?fY67zLNWknyMLv8YHNf8CBrYbdo9KTraO7mYujoKdlghMRFXBEQs3A//HE1Y?=
 =?us-ascii?Q?1/Vtdbekg1SSOfsDpmAc93l9f5URFnUJm2BSMGzjWwTP6SCVumWlv59tlHaV?=
 =?us-ascii?Q?mW7h+AtFSRK2xmG3uGRe/McZnPFzyUAvRZS4qBsgIfl1fVLZLyIQwkMRWTd9?=
 =?us-ascii?Q?wxyH+FhwzxfWc7YiGG02mWnIItlMHAvqYeFURP0kPXSIrD00Q2Ub7KJ5cKga?=
 =?us-ascii?Q?mu+X4W0pngrViVPXVe+dAKmFQPbfBYasR+SAEyf+ow0FEvg1FRw5SR7j0M2e?=
 =?us-ascii?Q?CamLmhFbP57ZpIc3J59zbrecK8OVAauq9CWOFvVb7wAB7QeW9G949j/i20Lw?=
 =?us-ascii?Q?EovjXp22DBaLHkVD5ZunWWZi6CgKl3aQ9GkCESDC6FWNJddy/VlAc5EojIhE?=
 =?us-ascii?Q?AKMXavrEG2INWq1ueBYYG1K/K1cZca2I/brp5DfIrEwRkHaPUmsYNnIbxlzy?=
 =?us-ascii?Q?O9QTJUe9INwEfOlhWWxf8TAOGN5r5mb0CYnL4qI0jP8KwUh0k1n5dSJp5dvh?=
 =?us-ascii?Q?x+G+mIjHVNXV5Q2mmSn0pyI2CKYI21qoxh+eR6n/r2f2W83ejdt21zQK7RBB?=
 =?us-ascii?Q?h14jq1fDWxBC6QIUllGv74KBIUA51kycrdOtMrvcn5pVkr68HH+yqdbw6bwe?=
 =?us-ascii?Q?32akzG3Pe7VfrikVgGj57E6/wJ1iqsCPavLE9o9LQTCu16GzVRzM6ilW6dBX?=
 =?us-ascii?Q?uGEZAXdNQsUukvH9l74OC1uZuHy6/ZukxOOQ98C4BLRvhT7qOUkWzjolUrNK?=
 =?us-ascii?Q?SAdsfUUZpZfPvepQADfeHAYQO5P5FzZkMgA0zltkCHwlRfzSKLRGMo5okMcj?=
 =?us-ascii?Q?XIa3YUkmPJcdeBNBBSI5/2hBh9PcBiEQE2o0zwoovaUtLIQqiEIcT+H0BNrv?=
 =?us-ascii?Q?4RkbNm2osy7luaXul39ij+2f/AWblbY/mSBoSaKO++CIEb2YbC+xEvwg5x58?=
 =?us-ascii?Q?f4siByhR1mdZ9J2IduURjtNCwpRB8SE6Qk3TYzccSpwauy76v14IVkAhyaHK?=
 =?us-ascii?Q?wKw3twICwjnPwzc/4lK2HkusU3Dq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIC+fHEY65P34XFGRPq+XpFgKmkoUOusxc4Ir879CjMH0s48lB6Sg67aVx2o?=
 =?us-ascii?Q?1rKnExKIDC9OaSF+jnCMrscZuMin1k/pU1oa0VQeNK18vR5vfOFuUllY7jLo?=
 =?us-ascii?Q?LBJudUJvJ4U1aF4PmIdxmLB8Z9fYnIk1hdYGUyETo2niVXsvWo4IWRFa6qOb?=
 =?us-ascii?Q?TsxQMbahewIvqi7UNE8G0KSEYb7dUGgUwzp305eUkCKc6hGwMTv3zVekT2ro?=
 =?us-ascii?Q?GGcv/rCsFr6LLVSfhH72Ig4i7sKzUwCdCqJ2a8qGVw2DDWrUxKSw5/mk/riD?=
 =?us-ascii?Q?7nS16tB/iC+cwr35IiWdUjhQue9N0dkXANWVR7k6248A2uxbcMkh0nCpqter?=
 =?us-ascii?Q?r+SD8JSxAzYQHEBLy/txbp+Q4ljTEjCZgif0iJvjMwFMKMRIYUVgR46IPs0m?=
 =?us-ascii?Q?mDnl+8BtdCbBhBGNjUQSR6MXnHC0TPAtI7zF751pSVbddJLtFM9OALqL+jNs?=
 =?us-ascii?Q?bEbE1iOJWETi4JmS6J+CfZgtHmqiswsx7x26aaEO13xLtknpBkT4voMo+Qb8?=
 =?us-ascii?Q?m2cpZi9zYmwia1EytWu0+MuwOOWDHQfZR5msk6ogryjgw3QWn43/zIrtHb0H?=
 =?us-ascii?Q?0AIhJFKuzK7ekwTtMWiWezmMtV5qNvKhb9TTf2x9/j6ehbUPITHIe+MxEoy1?=
 =?us-ascii?Q?nueQ4kS887P1FB32P0BtdEBzS4O9ZWOpEwkyKgOw5LaHjkFwN7VCqhdq65Gt?=
 =?us-ascii?Q?bOXR9raP7OrLl1vYJWpNyuR8T8brHfcvFjR3FGVw9HdP7+nJAythgzxxe/yv?=
 =?us-ascii?Q?M/XhXp642w0KKiqJF9h9WF3hxUhROK2ZnkXyZ1xHi7+wmePqi8LffAh9wANE?=
 =?us-ascii?Q?fTiT4d4TvTJbbUjoxYlvvGAkVL7zgKiQeU97fqxuAVoMk5kjdGLPEBt14p0L?=
 =?us-ascii?Q?uoMzYH9YqZpfC3Ef+BtHlvDm/LXGJUNwX/VZ02YlLkNyVN8mBAmogricTd3k?=
 =?us-ascii?Q?dt+6glmuR8roTFjKaxN4lUi9L4rnbIrf0Hvw3v+kxcO+RpBYZazn0s1c9O4Z?=
 =?us-ascii?Q?rALqeWHW195AOUo7zsyQpN5rLTJDSf44+7JZMu2lysOWZl2KtPObrgNQ0ZPH?=
 =?us-ascii?Q?nmVjsH6x6Y+BTjkYZRw7r8ysy6E7C/uf8xAKN+ClStdhtLpCBxDO391KqOwv?=
 =?us-ascii?Q?W/Znd5GDbSLTYVBKTAB5+LjFzlyEdMBhDvPxRG6R0S6hM/PMzToBS1hqURE+?=
 =?us-ascii?Q?5ltrWYa1s4tUnzHr7EnFxdJd95e0K6sZ8OTfZ7dMu7O4DfIBshMGWL0RXjxd?=
 =?us-ascii?Q?f0ngXg4HOknkPEXcv6tESpon4PI63SuxmXHAjRuT3PHL2UhMQivnn3OCxaBB?=
 =?us-ascii?Q?7Dqkbgi84PRUQnLoX86G1TYRF+4ybOTz0+BHJ0JvwI7mF4ne1XT8uvZrefqt?=
 =?us-ascii?Q?P07tBWuoA3wHve7usHRf11FgB5CuIiXUypSR3HA9LiebRAXZGZG0HoSMdeie?=
 =?us-ascii?Q?8YSX88e3EZnWCco3hbIY+2JE5dk3eXUdjTxSRFEc7yQIXW3cgyJ5uuOvQRO6?=
 =?us-ascii?Q?0qpMq3xgW6NGgFWGW+jFMeMjdSn0Rcpc2iq80OBtCqMGM3JMAPuuMAQ6ns34?=
 =?us-ascii?Q?9JXlAe2P6hBHmyXIOj7YIi294FIGZsnnWnoSBOfn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cebf45-10c6-44ee-1896-08dd56a9c9b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:08:59.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSB3yRZN0E8MJZjC/wqlnI7b+V4Yjdys4o1QK7H87J4Vx/1xGw7wMzkg/RSM6NfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

During __filemap_add_folio(), a shadow entry is covering n slots and a
folio covers m slots with m < n is to be added.  Instead of splitting all
n slots, only the m slots covered by the folio need to be split and the
remaining n-m shadow entries can be retained with orders ranging from m to
n-1.  This method only requires

	(n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)

new xa_nodes instead of
	(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT))

new xa_nodes, compared to the original xas_split_alloc() + xas_split()
one.  For example, to insert an order-0 folio when an order-9 shadow entry
is present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead of
8.

xas_try_split_min_order() is introduced to reduce the number of calls to
xas_try_split() during split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mattew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 include/linux/xarray.h |  7 +++++++
 lib/xarray.c           | 25 +++++++++++++++++++++++
 mm/filemap.c           | 45 +++++++++++++++++-------------------------
 3 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 4010195201c9..78eede109b1a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1556,6 +1556,7 @@ int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order);
+unsigned int xas_try_split_min_order(unsigned int order);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1582,6 +1583,12 @@ static inline void xas_try_split(struct xa_state *xas, void *entry,
 		unsigned int order)
 {
 }
+
+static inline unsigned int xas_try_split_min_order(unsigned int order)
+{
+	return 0;
+}
+
 #endif
 
 /**
diff --git a/lib/xarray.c b/lib/xarray.c
index bc197c96d171..8067182d3e43 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(xas_split);
 
+/**
+ * xas_try_split_min_order() - Minimal split order xas_try_split() can accept
+ * @order: Current entry order.
+ *
+ * xas_try_split() can split a multi-index entry to smaller than @order - 1 if
+ * no new xa_node is needed. This function provides the minimal order
+ * xas_try_split() supports.
+ *
+ * Return: the minimal order xas_try_split() supports
+ *
+ * Context: Any context.
+ *
+ */
+unsigned int xas_try_split_min_order(unsigned int order)
+{
+	if (order % XA_CHUNK_SHIFT == 0)
+		return order == 0 ? 0 : order - 1;
+
+	return order - (order % XA_CHUNK_SHIFT);
+}
+EXPORT_SYMBOL_GPL(xas_try_split_min_order);
+
 /**
  * xas_try_split() - Try to split a multi-index entry.
  * @xas: XArray operation state.
@@ -1144,6 +1166,9 @@ EXPORT_SYMBOL_GPL(xas_split);
  * needed, the function will use GFP_NOWAIT to get one if xas->xa_alloc is
  * NULL. If more new xa_node are needed, the function gives EINVAL error.
  *
+ * NOTE: use xas_try_split_min_order() to get next split order instead of
+ * @order - 1 if you want to minmize xas_try_split() calls.
+ *
  * Context: Any context.  The caller should hold the xa_lock.
  */
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order)
diff --git a/mm/filemap.c b/mm/filemap.c
index 2b860b59a521..cfb49ed659a1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -857,11 +857,10 @@ EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, index);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0;
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	bool huge;
 	long nr;
+	unsigned int forder = folio_order(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -870,7 +869,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	mapping_set_update(&xas, mapping);
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
-	xas_set_order(&xas, index, folio_order(folio));
 	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
@@ -880,7 +878,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->index = xas.xa_index;
 
 	for (;;) {
-		int order = -1, split_order = 0;
+		int order = -1;
 		void *entry, *old = NULL;
 
 		xas_lock_irq(&xas);
@@ -898,21 +896,25 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				order = xas_get_order(&xas);
 		}
 
-		/* entry may have changed before we re-acquire the lock */
-		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
-
 		if (old) {
-			if (order > 0 && order > folio_order(folio)) {
+			if (order > 0 && order > forder) {
+				unsigned int split_order = max(forder,
+						xas_try_split_min_order(order));
+
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
-				if (!alloced_order) {
-					split_order = order;
-					goto unlock;
+
+				while (order > forder) {
+					xas_set_order(&xas, index, split_order);
+					xas_try_split(&xas, old, order);
+					if (xas_error(&xas))
+						goto unlock;
+					order = split_order;
+					split_order =
+						max(xas_try_split_min_order(
+							    split_order),
+						    forder);
 				}
-				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
 			if (shadowp)
@@ -936,17 +938,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 unlock:
 		xas_unlock_irq(&xas);
 
-		/* split needed, alloc here and retry. */
-		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
-				goto error;
-			alloced_shadow = old;
-			alloced_order = split_order;
-			xas_reset(&xas);
-			continue;
-		}
-
 		if (!xas_nomem(&xas, gfp))
 			break;
 	}
-- 
2.47.2


