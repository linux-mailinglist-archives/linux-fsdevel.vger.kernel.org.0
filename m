Return-Path: <linux-fsdevel+bounces-41625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93CCA3365D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 04:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565EC167EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9282046A0;
	Thu, 13 Feb 2025 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUOt/I9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC294A29;
	Thu, 13 Feb 2025 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418393; cv=fail; b=WraBqf/G9iL6Dwc1dMktpSD++AvLLbc3uYpgwfp1FbcLYGKJYt/N+C+QUiYI7MmrKVpFjQ8URQKKIJizQB4oSe2WjIVa7EqpqmKV16UxEB/TtGv5d8tAmaA5vBTL1doydzh7d/oTXObe8LiikpeWzMYa0nc9CU74T7Q82+d7n5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418393; c=relaxed/simple;
	bh=wzhd2sGs6JuG9eyPADR2gedeSJLz9qlevt5a7kxH9Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlVmEmFh52aw8umrRKIyJFQFm8LgN5Hg/3zafgVem1sMSvKPwP4GO7MRSQr1SqfNcvbLVqWPpAmfP305mbhBMUvrihEe+391v/BHndMV37SRg/9yqdV99dCR/al8uON6P0u2tnHbwHCNpbJH88ksf6gwv5ifwk/b+6XoJsnhSBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DUOt/I9k; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq+3GvSgfeA7Ys8mnpYeo9fSeZT0xaDI1cVdkCcsrMKQ/B0XlIp0dMR6hfEbBkEtgkQ7sNgc8zBOdeIl9LXHddIl7o3ntbTdTgKQ5p7xbdBbKQfDSfEoZRiBpxXpksijtzNs1i21v1z5Yu9s9Urg+1EisiCPttms8HGSAekIVv5JckZMFr+1/M0hNBpsisNlT0PpfwhzcjjiZ+s9BfnHs5sIK+DjMpYSlaoBh3ABfE+IlMRJp4ZcEJTcAHbq1Y1dwZOnSyZ3Gdb6XJucPrK46PQSUiA0fqcYoJbpqnTQRgJmhjo6LAG3Nk8ds76hAMKcp3ryscE0SktagyJ5PpLvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXKitCivkhGwTXQEVYhBCDTne0e3zcGaxoEIIq6hU5I=;
 b=hoVLPedB1alM1klgWbZCHvIhsQyu3FWsbyRHe2eRaX61FtHoVZHR/Ve8jWG4ptKhcsNJmSo55jCbwlAe7j7GGoK4VJkEJGMtdhwByVoG9lJfG4zm+qmTRBe9KJNpT2Av/rn1JQOLNileM+V+nOjGH0asEJJfs0Vhv3Fe59nRT16IaGs+Qmq35c+SD3I2qdFakWgtYYcTAQjumSL4GC0QfgJphgdkEL7IG1X3jrKxAkJhyNKX8nkhIq4KAnGUwIekkkIzyw2Hxbkl1yfCGWABBcDt5OxOxhTwOcF/no02MZzyDQvKb0G4hehAnjHFFSLAfur9TXanSOa77lSv/a7ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXKitCivkhGwTXQEVYhBCDTne0e3zcGaxoEIIq6hU5I=;
 b=DUOt/I9kNPnmsGi3RQLGgxtTDtml3tCpN7R0dm7sVwXA8uKYjngNJRREp5Y1mC9ogHvMuIfT2i6SVLL3zSjnYTjcjj3OyHnlR4h3W6aU08wzwtsshDPrOVldVy7b4xYeVnO364ynV0nzYp+4Ahy98Wcwg/m9l/IZW7iaorxlIl+0ddWUWjRoUVJ+aWZ1TR9jgwwjFBtZAMGeMw82g8LL9kZVY284QZftcvNt9vzBwUvYjflrf2Rs/a5D0x64lby+iWssu2hlpiBwPIIaFzcZrwot/e+5B6mJEpLrBcyc7DZmnWulb4HXszauC/6mU9yc2P/r3ZA8BEa7PoeLXKMwlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 13 Feb 2025 03:46:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 03:46:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 0/2] Minimize xa_node allocation during xarry split
Date: Wed, 12 Feb 2025 22:46:27 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <324AA2B9-418E-423E-80B3-D75A19D52A4C@nvidia.com>
In-Reply-To: <20250213034355.516610-1-ziy@nvidia.com>
References: <20250213034355.516610-1-ziy@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e888e8-ee94-4ba6-d2da-08dd4be0ffac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7RHdKsF3Q80V/f0LrP4HBRb2SEuNuwtU6ephMDnpup8+rEc+uqAGuBvn6IZp?=
 =?us-ascii?Q?pdMq4yrAcZfHz0grsC6NznuSyxfQOYQ5kuCzE6HSX3nDE5wYp6BUPNQ//hYm?=
 =?us-ascii?Q?nCvc3HHsDU1ZAciJwo/slX92+PqKThqI8npgfv782EBQZMxeoaHf5axNAPTm?=
 =?us-ascii?Q?IlExHQ8tbJy+W4OHLpyA/PrrMengQx1IE+Fb/ViaMs5Ra17JlkhO7PHbhB8h?=
 =?us-ascii?Q?VVPxaD3YdICb0bGWkY0xYEF8drtkon7dKiUSUl42hW/OE7h4yTuu4KP/s3gQ?=
 =?us-ascii?Q?AFjIwOggE9INaMGVtOt8ByVqdVfb8vTNqQoCrHB5CRMWr5JcpInUV1znm3IB?=
 =?us-ascii?Q?KWIBNkslWqC8HlRt2mFAieJIjwgLYVOeceT78s5Lah5P3v9NpqT49wW7pxF2?=
 =?us-ascii?Q?gTEREm6al/spXOt7dKcJrfsHHhWxXWua81UCdZDYhoBzYtC6QrK5Y6sYULQe?=
 =?us-ascii?Q?pZwFgXjreIjjT3RJ0XVHNu4VcA5fPrYml1zgHtelVab36QtpNcR9bKi6x02P?=
 =?us-ascii?Q?cWxmhovwdbc0z1vBJxapGuJzu4O1qBbqVwgjmWLB8uBepnh1NgfRrJUMVRHa?=
 =?us-ascii?Q?1KMBVxGCdzJbMz/5prYL37lv8gM0UQh2t/666GXZ3A7znhcDb/Uhgd13vEOj?=
 =?us-ascii?Q?K3CyZvGQIBSsntPCenTtmT8QDysp4s4YoUOkd3+jrkuMrphTxIBoX8YowDb0?=
 =?us-ascii?Q?42luPQZFpojhPDaJUShwovqCopIxKVsMT7cEu7Q03nkTw99LhaEv1NVZcX6l?=
 =?us-ascii?Q?f7LAqvAYnr55OpjjlSNj4xXJYOd4sBu2Jy9IItASFyBJHdymU4p9zVQ6LUwv?=
 =?us-ascii?Q?S/84BsVA0NHGL/XFyIOrpv+XoSH1AVIf/RR7o2QKt426NxDrz3VURI8Og0ci?=
 =?us-ascii?Q?fGdP8KFbxekTxMC8ded6jMtXGa1MyVHJQNqAefVPmaKst1mNrQJ5VKKvCW2G?=
 =?us-ascii?Q?T5QmM823r7adlbiVDH9yVEM3aboMyINBh8dfxdq3LA6/LpFuj6ZepDzgENTl?=
 =?us-ascii?Q?P6pPEVuhqAXCbQVyVhwgS5G59srpHkwbdlRxYNbwzEOzSBnetEjUa3fSjP7x?=
 =?us-ascii?Q?FdfAYT2D6hz8i6eiJncXhT0f2r7NmuC26f4YKuGZz9eCo8cfscQKruDdiyZO?=
 =?us-ascii?Q?GdfpG6rf4OOugJB/DsRIo9m+KPeHR2DpFxKSbqLfVFls9rU9u1S9bbTIlOxW?=
 =?us-ascii?Q?kYrlb4jgaDr93mzJD4gin4cxks2nHsxHqTVSgbcBZDCM2DwmQPm4Q46h4tOC?=
 =?us-ascii?Q?DHiB052qwSt2hnElB2iMIQTdzw2y3Hwji0t1d8wlf0dJyCHEx6TeADeExbQZ?=
 =?us-ascii?Q?NpvhiNfq67nB386NFkfdUL3MLO41N3nqYGTMjkM6p1LYHNKnLJeIc463NIsi?=
 =?us-ascii?Q?8o0WMUPxS/IEDFuA9g+PTRsT20vC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RMZ0BXgg5OTFGSjkP7jkT64ByvPRIkGFTOrNd10eUVJiIqcKjfli4MuhS901?=
 =?us-ascii?Q?Et5v/NvRtlHqg7GdZc1V2BEfry2t7KRStBzVtYGW//bwEA1fZEl7zKDoRJQY?=
 =?us-ascii?Q?KPfaZQ5QPyFReQaIkcb/sahMc9aS8UUbXwELEV4ORq6AergMufL6tZEXPM2+?=
 =?us-ascii?Q?DdinyH3LR+GL9Z4djY1+bCWtCbabKA4KAyAd9hFNg3KZDES2fgjV2mvOgSR8?=
 =?us-ascii?Q?6JfEMDG2Hmfhj8ztfphYV+mYd+q5gLxwqKxxgI507Mah32rTIUbpQbDEf885?=
 =?us-ascii?Q?TdrRyES4shrXsIUjb2jJAM0qHtkQBnORZR1PuVCgMBJ255bUE5g3qVPCz8iU?=
 =?us-ascii?Q?MeDE1sH1EoobrmiaGML7VvQobe1gBxnwqxCPsYEKMOZ2qiAAOtSFVkLKxl3N?=
 =?us-ascii?Q?iq8bIZzvauXPXG3orJ277BVqlZpu7ly2Um7rH16X44N7xeNcN0sljFl86SIA?=
 =?us-ascii?Q?YpYCxGJNUkuS8/AEJ41W2ycpSm6o97yo4LIZXNTpqo79QoLgsFXKi4U+tWt4?=
 =?us-ascii?Q?ezaC2/6lPuXl2K1GG/ZfgtsUuAM2okFO/pII7ihmV5WFyEtCfejo19M4Aqr6?=
 =?us-ascii?Q?jG/I1NeXmzq7Tc5DqKC+oYUDBmtPkURnh2YESKqi8PIyxhD0mmPF74ITLdLe?=
 =?us-ascii?Q?impxwBp6OoO4LrOE+bE9sEUS71ac+PQxOPJwm3hN9Wz2iwJjboRvTzjTpdSh?=
 =?us-ascii?Q?pGLOwwrSQx+esiqdkK90+xcUtWYJWz0JAeyIk+uKNqK55IiXM5N8h5PrUhRG?=
 =?us-ascii?Q?GyYMvAfJqgnJu90Hfyt5x8Y941u6/Rt8EHOG2dtlHPAGO60wst0LAKU9TNEd?=
 =?us-ascii?Q?o9SoRBWaCvO9NnNrlzqYtBMcaMLhTH56VLO3xc4Gw3Vfl/6sx8Fp0XI7THFK?=
 =?us-ascii?Q?82HI6ggGhamW0VrWd/isNZ+Rv2/FVoKc5jPl8GeAThqOW5UwpDclWM9EevHd?=
 =?us-ascii?Q?hhQJ+QQEQX/qHbj4+1N+ZuPjUe0/1Q5eMwwly+IsfPCyg4F5iuTDDGX9Sc5m?=
 =?us-ascii?Q?mSubRYdSYETzkhmTgzcw72Tf5BMX1fGyOk0fUkXymVUl4B4J39kpHj7GVPb/?=
 =?us-ascii?Q?wwkHWAKJAF7CPBoRz2wVc12H5WsG3Y3Pnk2F1HnrgMyKN4tGbwUVAaAiqeuf?=
 =?us-ascii?Q?++8DLhFFZ3wdD/VE/DaHYB4fNO9iOoUDmejQFpJBAgUm//In60MlaXdtqAi0?=
 =?us-ascii?Q?eoaJVmEZ2D+iRi5aZjFBpfKsQ0tTC1S8CfYPCqMw7KJOHFYo0dZ3syoVHTDl?=
 =?us-ascii?Q?Vy4zyUCTKG59vtGm0Fm1AB/TRjru4OzfFou9+vGia99RIcG85qOmSDSKIbiz?=
 =?us-ascii?Q?yGMl7i/5HFYUCSApU5HjrFB+wRZStrpaibYIP0i3pbYzwIKGuHqm650jYSA6?=
 =?us-ascii?Q?br+ukjdOxasnRhU5LcIebprbm0tFgEliUPTzhevuk4pqH+px8eyAAOoeJzdq?=
 =?us-ascii?Q?df/QALpvrACOyw6Qa6oE3SCKztzyPVPcpnqddCGbJroaiR4SuGnw8Gyq29RS?=
 =?us-ascii?Q?ckCxBj1iTCVUSK/INneKUTBmpAuuVBAAi3Yb9H3BaqbajKvuk1GnBjWqcSjS?=
 =?us-ascii?Q?LILuMb2mvibz8XDsFRO0IdKDaOhPfIa5vc6sJg4y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e888e8-ee94-4ba6-d2da-08dd4be0ffac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:46:29.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CAoCyJHppYCs1B+8llM9C9Pd3O1TLy1nLhKRmriSFmsnOqJGSd1d7okl/qIvMay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

On 12 Feb 2025, at 22:43, Zi Yan wrote:

> Hi all,
>
> When splitting a multi-index entry in XArray from order-n to order-m,
> existing xas_split_alloc()+xas_split() approach requires
> 2^(n % XA_CHUNK_SHIFT) xa_node allocations. But its callers,
> __filemap_add_folio() and shmem_split_large_entry(), use at most 1 xa_node.
> To minimize xa_node allocation and remove the limitation of no split from
> order-12 (or above) to order-0 (or anything between 0 and 5)[1],
> xas_try_split() was added[2], which allocates
> (n / XA_CHUNK_SHIFT - m / XA_CHUNK_SHIFT) xa_node. It is used
> for non-uniform folio split, but can be used by __filemap_add_folio()
> and shmem_split_large_entry().
>
> xas_split_alloc() and xas_split() split an order-9 to order-0:
>
>          ---------------------------------
>          |   |   |   |   |   |   |   |   |
>          | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>          |   |   |   |   |   |   |   |   |
>          ---------------------------------
>            |   |                   |   |
>      -------   ---               ---   -------
>      |           |     ...       |           |
>      V           V               V           V
> ----------- -----------     ----------- -----------
> | xa_node | | xa_node | ... | xa_node | | xa_node |
> ----------- -----------     ----------- -----------
>
> xas_try_split() splits an order-9 to order-0:
>    ---------------------------------
>    |   |   |   |   |   |   |   |   |
>    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>    |   |   |   |   |   |   |   |   |
>    ---------------------------------
>      |
>      |
>      V
> -----------
> | xa_node |
> -----------
>
> xas_try_split() is designed to be called iteratively with n = m + 1.
> xas_try_split_mini_order() is added to minmize the number of calls to
> xas_try_split() by telling the caller the next minimal order to split to
> instead of n - 1. Splitting order-n to order-m when m= l * XA_CHUNK_SHIFT
> does not require xa_node allocation and requires 1 xa_node
> when n=l * XA_CHUNK_SHIFT and m = n - 1, so it is OK to use
> xas_try_split() with n > m + 1 when no new xa_node is needed.
>
> xfstests quick group test passed on xfs and tmpfs.
>
> Let me know your comments.

The patch is on top of mm-everything-2025-02-13-02-18.

>
>
> [1] https://lore.kernel.org/linux-mm/Z6YX3RznGLUD07Ao@casper.infradead.org/
> [2] https://lore.kernel.org/linux-mm/20250211155034.268962-2-ziy@nvidia.com/
>
> Zi Yan (2):
>   mm/filemap: use xas_try_split() in __filemap_add_folio().
>   mm/shmem: use xas_try_split() in shmem_split_large_entry().
>
>  include/linux/xarray.h |  7 +++++++
>  lib/xarray.c           | 25 +++++++++++++++++++++++
>  mm/filemap.c           | 46 +++++++++++++++++-------------------------
>  mm/shmem.c             | 43 +++++++++++++++------------------------
>  4 files changed, 67 insertions(+), 54 deletions(-)
>
> -- 
> 2.47.2


Best Regards,
Yan, Zi

