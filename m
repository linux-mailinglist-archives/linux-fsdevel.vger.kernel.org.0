Return-Path: <linux-fsdevel+bounces-42726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D1A46D09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C89E16B377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0E2580F4;
	Wed, 26 Feb 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKD/uAZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1C14A627;
	Wed, 26 Feb 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604143; cv=fail; b=RmpdLgaq9yveywh+7+JGzBin3oLkD0+pokFa0WFpCtx5PNl4O4KkhQS3BuywdhlqLr6xCVyKXdVvTT5cCJFBEx/K19B8QxAGhA5yJOKp+E7jAWAabTsYoW7IfoaLjhz4HPo5BoDsuuVusoLNBcH5XPPa4AZ7wJf5IpSnxCAmZ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604143; c=relaxed/simple;
	bh=nEwbRqXJLySrnuBRGxKbxDlDIlUGMGwx71ZNKyhZHUI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=soVAdJxRfIByY6vP9Js9nKduDn1BNoV9DRoGc1Uvh3Wfety8cDper0cG2djFckqgfJYAKE4uAgY2ozTMBFbqGD1JQ8MaS8nWOStZWR1RhHkTsP2E6leKgwSH44+k3tGa2AxJVWzCQWutaIBHP1acLq7Ly/POWMwwLAHAqygAkf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKD/uAZh; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbWpIbysX4dBZnx+Iol8ZYgnad0ClqVw7+sjHNAbtxiDGmilSzL9+lXwf7Eq1t531O9ZuYbb6P/hUlbidigQ2PMkdNRVFnacOiNvA2ail/21n7Z1fkPp4goet9I8ggdA1daB3pRmE7xCOo+oZSDHqh3GDyPN5LOOrSoflztq2u2mVA9kmQuUl8cqF+MhDPc6dasitkn0tVMGNhONhzUum9CmglrdlGt8GfFn3UaBA7gh8SPsbYWv6ZzZzQRYfMeWpG+yoUUpypJkJWghOkMj7jcnHUrIJApJQDpDyJ4z2ONc//DqKUDS4/Bg/tzd6OAc1C3tvgEX3+gcTUUCVL6etQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtNlXNLzcd1UBbvYE90tIcoe9L9SDF2ng163rpUJqQw=;
 b=su3Gfn40AWcj92pKlqdasC09wxPK4qNkvQwovfQi9RwiK8zJGaZ2G+8FznvT6qAqsMaNkGp/GaD0qWJVqOvPOl7zen6Xq0TZGWGlss6PjFxBX00cvXvrgps9rOmqvuLfUtR6Mwp2UyuDwvkI2f6z8TAU0isP2SY7ODZrfp2ZnN9Q+Uw/zDmo8JFUo+dn+CdXqtfUDY7MspHlSqoE9c58yRH4SVUHf/2CBT2Ksaxc8s7qs6dX7Httn1FZknGIZ4KuvSjIPPsLYUe8r/aSy2yCMRwmwWGAjGzI9DG0ExGSqgjYAk8i2DwgNbTyh4MleAvF2KK1F7Y/wp6wb7x8lSvTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtNlXNLzcd1UBbvYE90tIcoe9L9SDF2ng163rpUJqQw=;
 b=bKD/uAZhl5jmpBvzUUhYjIY9axIfPR9GXvUegYRDo/hTOAKgR/CZf8tXYxTNSJh8Pme3ywQ3Ec3nhP24TQ+syxmoGPsDIg7gXwehEJfTTYIal7DAUoO6tLiSOsaNny07O+t/80MvzRx64hvA9g3/LfzPdZXAwj9Za46PMGdWtmC+3hBa2IMyDyv+3P51Nder4vfe+wCJ02YZkZxlVKIDgBWu5grDAAS/eXkrOo7nBuh4xm3nvbaLUXGtz5ieA19D0gfm9PPGLJKzN3gMKr4LqDyBKXzW14eDL2cTkbKt7QJ8yz/mWpu3azShFkU3oVxJMSKov2xHnXA5itXP+Nda6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 21:08:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:08:57 +0000
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
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 0/2] Minimize xa_node allocation during xarry split
Date: Wed, 26 Feb 2025 16:08:52 -0500
Message-ID: <20250226210854.2045816-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:207:3c::49) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 12252f1b-a9f7-446f-db85-08dd56a9c8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Tom8dogslkwCerRHR0eTe0LtLb02Q14n2AtlC4D+TdJdWruS5p8WMFhc0Ns?=
 =?us-ascii?Q?Hru/+t8sMfIC+FKDXt58gWXyqW13wuqc0rHyNATDGl9IpLgDBAZbtd8uowoL?=
 =?us-ascii?Q?kZ/3e/sMbEh8mCwqdrkDyDFSwV5A5vszDAGBp+FQN+rfNkTUTS9DwpFsgWHn?=
 =?us-ascii?Q?6gHEBYKaejaaqj83/PdVThz1gTQ5FtBdSUAdpxEwMF9gO9IwjxSlDqv9TSrV?=
 =?us-ascii?Q?BAzqRZz6lDToAbmMt2rDLaUG1HcCcQsznATFCN35W2h5ha/mgunjij3bu+Wz?=
 =?us-ascii?Q?jE6zNPh+zlysM2ZRAsdK2iVEEAiahLSJ974suVKI5ZqiLPUtmPFy/XeLdkWy?=
 =?us-ascii?Q?42O1xYwG+7KDbYKRXirQqJ2AVaZxlV07KhhYX57TysPBxkP0HjPCJSo20HUL?=
 =?us-ascii?Q?3TXxz12SpiYPCdXwD3fIBLPk22lEPSqPx73NJBV61hXwUcWNDWb0BeN2ePp2?=
 =?us-ascii?Q?G5SydNrwO78ZK2DY014WM0Jb8nWfTX95jUVncJMj/hcBQI+oOxSLkSRUGDGr?=
 =?us-ascii?Q?MfZxj1/DcLF2ZAVe/5LceKpC4Jrd6KWIraApCnBHthfPgmkAJ+0AHSImdRo5?=
 =?us-ascii?Q?cXuTXKQuKyyemXKmJWuZlHl1bixM+IBg91KKNiVnpKykEHhvLUg+asuJWEYw?=
 =?us-ascii?Q?mxPFr1WTgCuag71O2jUS0f77APC+qlDbIaNfl8YRgGmiwZBmwi5TmlYvVq/C?=
 =?us-ascii?Q?CEVdezwHp0uZMe+3LMJ2B2K1NDm4iljEcAZQRL7Jc6lmwD8g+YIijxhN+fAd?=
 =?us-ascii?Q?9NpODWISdNtzr941HTdGGHf0Wq21YpZrHpgbwqzcWEKa/srt0kiR8mTRpJrn?=
 =?us-ascii?Q?xzf0Nj1aFeLmDSEBpZTKnFgkZBvCbuIp7MNyMQ7ePlM5tRIFIxLnSewG6tPo?=
 =?us-ascii?Q?jSKIJaQLR67lUsPwr6PE/YCwlV8Myf+s6sNdZl8bY0sny8MHvMGVAqOONg0H?=
 =?us-ascii?Q?rPeKqHdkxFfqIpX3gfxg5puy3SMuZ4vOVa6i1IiyfoFb8cc+jYwWHRkKpT3D?=
 =?us-ascii?Q?XiL2TLVFMEcNMRdwYdVdD78nVbRtp5B6CAjrx0VRciziZTud2RzDFdagCHqB?=
 =?us-ascii?Q?p6bhxJMHZnItXDIbzWOeWHhDJfa6Y1MvtNuVzwlNGaShXFKQuXLv477htG27?=
 =?us-ascii?Q?Ecka1hbIk08kTURwoKYLduqljo21ETiL7nzXav3b+BBDvOKOY8cBawWflaLw?=
 =?us-ascii?Q?vDJ7ddp1FH/8pxQSySiXcnw118GZ2BTjN/uwWOBGQloo1U+5qmuhods4T5kc?=
 =?us-ascii?Q?gN7sTROYENksCVY2dCz69vwBUInajF1adFt57ernzQL7sU4Uk6T3HWA0Hbxb?=
 =?us-ascii?Q?A7+s0WnVmEFQXEGQeBHFWrY7tvffFeU5dCZYCAHkH7IxgU2IAHHCXZKFU9UK?=
 =?us-ascii?Q?GtC1vo5HK00Sju0dxTzKUW7+l4yT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQ8QcnWXnE8u3WhFwsQrddXmChvyzvhkcM9oRBuG3G6JQHmrNgiYX9p6IcxY?=
 =?us-ascii?Q?s6lx0tN4JjePr4AYz2W63c8nxvJIXIJsjhSsMFj3OzbJlv1RR4ZYLD+fChG6?=
 =?us-ascii?Q?dAbKzsKyE1Pzg1wxHuuDr6EcrNYJ+BjSrsHOknact/72cHqauKPPIo24ZhaR?=
 =?us-ascii?Q?q+IzZBkHtRHpmavcwNTipxrHbXJJezd9ay6yz1kf2Lze1B2dZZqkORlBPK3Y?=
 =?us-ascii?Q?7VbfpjkSWI3gCa6xKWYO3Hdf44l8SMZNUlpsM9yuanamDY0V7uilDvsADmDb?=
 =?us-ascii?Q?KTrmegrIblbt2F4gvVBkouSD7Y5bbzqCteA89qJSojmK0fKmyRmftEanoobr?=
 =?us-ascii?Q?rpHi3VYdrcFPIpkJTdXQYmNJo9Y/6htUbTbsxQlOy8GOw4kKx7lx0yuhIhB6?=
 =?us-ascii?Q?XUk2wgtp3Sfd7RhbK5OMZsQzTbzeVtmg/1FyZ5+uDSMBvekM/iTwnWrCqtW+?=
 =?us-ascii?Q?VrCE3JXZWyjh2aQgvXNFYwjEvS8YoLqR0oex3MHZLSy2VitrmgbDw1BZevhJ?=
 =?us-ascii?Q?TFii/RZQj4wMXAqKlUJfnQTslJHsxR0C5x0aMyJGZqFta5jrjFC/VMx0h1z+?=
 =?us-ascii?Q?IkvcLNEe7+GMA9Z7KVXONxQLXAw65atZXH55n3U+KIzTXA4QSB8NzQgIzqIs?=
 =?us-ascii?Q?w52x4A/8ZqHLmyxK/Hz+dXWwEzvpqGcxCnrqCDVqdgkWf01K4CywTMlFTmWJ?=
 =?us-ascii?Q?begG26RfbIiOm5hT+UdbhY/ZYxyybWFIcG0d8DB2EttPbw+scckva7gpBy2R?=
 =?us-ascii?Q?o4j21Nsv/OjMwuLDMLK5FnHDIpGIcnCA412hsGeK4MHQn6XBy4fjw6Ql29cw?=
 =?us-ascii?Q?HqoFvFA3Zb7l6CfbmjkEx4sWJ2SWm6kPGUeTJ/QHLSoemKUm3TvGOVSgavew?=
 =?us-ascii?Q?34rLxYoYSA9N5XScbd0wlSTF7h5qHokJM89hM+FCznRHl/BtpT4QQcDTpdKR?=
 =?us-ascii?Q?3f82gxZxn4pVQyvky7dp9T2jOAQuAePJcUsi/FtEumTIFt7FqEtT7Es9Ry5A?=
 =?us-ascii?Q?es6DRMqGLvA5QOU0io+qyGwLjmoPZ57b8FbHbykeCZJnohm+Bxi5N1LYoX2y?=
 =?us-ascii?Q?z0fko20xphdq45/6CXtlX6Cw92ifwOn+wTfmcI+SXRM718puR8KIe5ODFmXP?=
 =?us-ascii?Q?VzQmySOq7AbBiRioECmF4PmwjorRzDQ15gMrgXSgqwAxH7ZoqhO+xY8re2oW?=
 =?us-ascii?Q?s+NYNC4NmUIHXceoZkp3FRiW08N5bZcXha9kmHvUwPaid6b9qUKy9e5NZl15?=
 =?us-ascii?Q?fECfu7BdHsRtMS3gbkb22p8+4zqNTFJoP6SqoO/3UDL/TYoBrs+L/41la2+e?=
 =?us-ascii?Q?bWi8F4faYBNT7GhtF+vGbbywcIYI2lDRxuZfnTddwGpryVHnNBvwdvYOGkBC?=
 =?us-ascii?Q?lkQH3QSwtK5X+BrLjCYYWgzaNS9sKaNajnECLpTegQAjSx08bq+IKjJ8Cf1J?=
 =?us-ascii?Q?haWXSKnJyWJ0bXMRpZxvH/wSIsLABIKX5ZObT8CmcDutlJY9umeuV2nTRmk+?=
 =?us-ascii?Q?FVzUGm4oLXG2X7aNJNMOuegEuO6E6nng40aZ0vXdzQHwhuAJZSd/599W83kD?=
 =?us-ascii?Q?1kPOT2daKxZxf3c+XbrgPWQOGl0lT2dEQrzlVfEj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12252f1b-a9f7-446f-db85-08dd56a9c8e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:08:57.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbdqqOnGWA383FOC6NEswSZuvYJE7kHAoolfQcdc3a0uqEVDrXbxNQ7gmlfnYXvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

Hi all,

When splitting a multi-index entry in XArray from order-n to order-m,
existing xas_split_alloc()+xas_split() approach requires
2^(n % XA_CHUNK_SHIFT) xa_node allocations. But its callers,
__filemap_add_folio() and shmem_split_large_entry(), use at most 1 xa_node.
To minimize xa_node allocation and remove the limitation of no split from
order-12 (or above) to order-0 (or anything between 0 and 5)[1],
xas_try_split() was added[2], which allocates
(n / XA_CHUNK_SHIFT - m / XA_CHUNK_SHIFT) xa_node. It is used
for non-uniform folio split, but can be used by __filemap_add_folio()
and shmem_split_large_entry().

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

xas_try_split() is designed to be called iteratively with n = m + 1.
xas_try_split_mini_order() is added to minmize the number of calls to
xas_try_split() by telling the caller the next minimal order to split to
instead of n - 1. Splitting order-n to order-m when m= l * XA_CHUNK_SHIFT
does not require xa_node allocation and requires 1 xa_node
when n=l * XA_CHUNK_SHIFT and m = n - 1, so it is OK to use
xas_try_split() with n > m + 1 when no new xa_node is needed.

xfstests quick group test passed on xfs and tmpfs.

It is on top of Buddy allocator like (or non-uniform)
folio split V9[2], which is on top of mm-everything-2025-02-26-03-56.

Changelog
===
From V2[3]:
1. Fixed shmem_split_large_entry() by setting swap offset correct.
   (Thank Baolin for the detailed review)
2. Used updated xas_try_split() to avoid a bug when xa_node is allocated
   by xas_nomem() instead of xas_try_split() itself.

Let me know your comments.


[1] https://lore.kernel.org/linux-mm/Z6YX3RznGLUD07Ao@casper.infradead.org/
[2] https://lore.kernel.org/linux-mm/20250226210032.2044041-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20250218235444.1543173-1-ziy@nvidia.com/


Zi Yan (2):
  mm/filemap: use xas_try_split() in __filemap_add_folio()
  mm/shmem: use xas_try_split() in shmem_split_large_entry()

 include/linux/xarray.h |  7 +++++
 lib/xarray.c           | 25 ++++++++++++++++++
 mm/filemap.c           | 45 +++++++++++++-------------------
 mm/shmem.c             | 59 ++++++++++++++++++++----------------------
 4 files changed, 78 insertions(+), 58 deletions(-)

-- 
2.47.2


