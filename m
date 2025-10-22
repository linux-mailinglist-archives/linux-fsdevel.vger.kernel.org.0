Return-Path: <linux-fsdevel+bounces-65217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45BBFE379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F64E356CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84242FFF80;
	Wed, 22 Oct 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SnS8CVSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02402FF668;
	Wed, 22 Oct 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166039; cv=fail; b=EN4X5ATPkzfulZ+AUGQDdKhWLHNdgtwJBod+GbZkAnNkxvUU6lIGp1Ed8BliWzvHODD05pkNb37QPMasIS8KTU+1sGJNbf1cB0thPJBhKLDpZ9nn3rlBHWtETG7xalFkYg9NCaW8OohTp7LRNVrbY4Kfktq31/yriZI52d9Fm0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166039; c=relaxed/simple;
	bh=9/GVDU5u7Y/k6dCdyv+oXyO8/qx0JGr2RgwRqlYpwXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hidJ/PlNZ609vgU8CyvezTUC9rzMmTzz602RtHJUgyhRAhWAZdzf3h6XdyGbreOJTxPd1k2d6IrD1m3n/88p3XUm++YZMgA7jxwN0jJY/hJ0fHs5MtSKnaVNuh85ZtwUAl/FYbtfrNRrSUNx6nsHd7YZ2Rm600rLXiIcC5DaQrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SnS8CVSb; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oohCNjs4i7rSCMTsRbRh+rTFDjEh2o63qfLrqwOkvhOwV3OOaUWwpQjf37Uj/oY6+0Zt38rX0XLSKuSP4YrlRDzk80v+4O3NwwdnSmE+nHPRe4XiNPuVQWzJfFNaxzaooBJZeZtI2Lzj4A49QqOD5qNpmNS+9vLZJRmCzPhWhTZq7PSYc+Rxf9N9cFGH9f3Eo8haBRa/n8b4ebUKU6rKuZFPGzDpSp/dEmY5IeCTV2/vmgemamYGCoSs9vxGvTir40uzuIbYmSM992yoTUNFGiJP5kn0uqfYNTswq+zovu5+FMuy0BNg8xfbkm+fBevNybxfk6+DHvQRaFMcnow/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CCrx5pYo1hay+wJxBadJsZ55Bkhhe8umxERUCDNgVs=;
 b=vE3boC24DzrOJv/iltHR5RVwh63RvevnbMT9H1Ohwd0ZRlwRBROQ60TWNqjqDkITunCXPNdwpXbSmdVw70bSDiXqIXUAvmucClTC6UOnv/Bo++akfjRPiXe7vJdNKobrIkWw/zTPlRgLU3r3BI3yp8H6OFxrkh8V9emA8SohGH8gB2AQ549uyN3gE5upnvq54m1aC3/3TB1aePTzK8eWAljrXIlhTKGb9f9GmmIG96ow0Tt3l8cj88tyqfwV6zkxySLHDKXzxordWZTuDYAcjKsfE2C+79knuF3gwYE06ZcxuzpuiXY3FtxABgayDv6DWmaQcWgjdSx87a7SeICqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CCrx5pYo1hay+wJxBadJsZ55Bkhhe8umxERUCDNgVs=;
 b=SnS8CVSb/2DoKvlE77dEpVISA+RIJLbeiI3gk+cwl2FXkf8k3jWwyRHz/M1NxJVAC1IC/sS1o1iF0a8jUjoxG0nN0CdgaqNTdk/vNQ0RNfTLNJilruYHSwEfGdLpxm3e59umQJ2i7CuRU2KsYDvTrKEDpiddPSnK1qggWXeyv52qz1VhjoYkGwdSaBDvCTCCT5plF5OeS2VfbRFU0CaPek96xnnH3GqbTrDRKxWm7NvNf1FSyqFVpoOOOo0Tr8qD0r6fzkggepR5edSbjyF7QVxvakO2IcO5z4Sb6+LpssI4oGoHAr+A85oNvbBvTe23VA6WJrodsYgq1P2WDIyloQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Wed, 22 Oct 2025 20:47:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:47:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: <linmiaohe@huawei.com>, <david@redhat.com>, <jane.chu@oracle.com>
Cc: <kernel@pankajraghav.com>, <ziy@nvidia.com>, <akpm@linux-foundation.org>,
 <mcgrof@kernel.org>, <nao.horiguchi@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/4] Optimize folio split in memory failure
Date: Wed, 22 Oct 2025 16:47:08 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <1AE28DE5-1E0A-432B-B21B-61E0E3F54909@nvidia.com>
In-Reply-To: <20251022033531.389351-1-ziy@nvidia.com>
References: <20251022033531.389351-1-ziy@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 610a1f13-e2d1-4176-5af2-08de11ac2cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHwIP0+O3owETpTC6aim5ihriO+tMgqnX7Tj3vmdTvuz5wlXtdxCUUCJdmP4?=
 =?us-ascii?Q?swCCSppUOvYVhMJLl0LJ4AMYC7Yl5wIZALsr71nFC/JpzAGQUPaO6F+kS+oT?=
 =?us-ascii?Q?UManKFfSZgfaEo2hOD0e1CieIB3fw0aw0JoA02UWTUjVqZXb1VvFcVLODbig?=
 =?us-ascii?Q?gSfcCD2rLCaI90l+KN/LH4kKI99VkCJJ8erRz3Ss/Qi4644DxUFMC6ydprrf?=
 =?us-ascii?Q?rO1ejRYuNqkONwuJyCH8c6ajIsE2ZMZYgesNx3wmyzpEplRCDab/wBIQhLT4?=
 =?us-ascii?Q?Oc33vcXIjd5+o1sjQ4hTRis96v8cCxEhBDhR4d9SQhglBalKhVOYGlIJJzFV?=
 =?us-ascii?Q?F8zh0R9W9AfVrPrHw379lgpTF9jGQ6j0aBGwrGqJz6jJeLk8ylwNnBhWK4hS?=
 =?us-ascii?Q?c9T+uMHDmwxFxapE6r0haOe413V+Ecj4250dBhDBxbl4juxMlOcHfDccO8UN?=
 =?us-ascii?Q?HWqMuIEqRxHxBsP5dxElWdXVYOKF94NZtZ885ge6BWjjMJgzRwe2eF4hPgAY?=
 =?us-ascii?Q?fLtJsM0bYhtyhrn+L3KAqnWNEreWaTx9xybddQe+1XEFe7izXDBbcDLzJm85?=
 =?us-ascii?Q?oesSWE3llf8x4U4R2n9a/O6IDRr1MoUWBh7c959xUbXt/H2llyefLu7E51yY?=
 =?us-ascii?Q?NbhY5zddqvg74SKawizalLnh+SDTwt56IODVCoeJnINKJoAjhkXypffAa/0t?=
 =?us-ascii?Q?A2gmbGTktKZbYHNCE9aqG6KNQegdGBsQviQJEGHZ66wN62EmXb138O9jmwY3?=
 =?us-ascii?Q?mNYbaS6rrNh1cuMTTC33mRdqzjldt4KiDldjsPtZQqe3pf71lBQbiN+ThoO/?=
 =?us-ascii?Q?7gqShepPTGPY12PRJupppsS8OpBcbRXGs6BXvd5t+HOvq7JlICMf4jpeXdYd?=
 =?us-ascii?Q?Uskh/mYTnmlEV1eYC9mVHvb8GHpA9+PbwOEmXH5VZwBsEuNNwngoyH350Kb1?=
 =?us-ascii?Q?Ra4Po8mJyuxJu0ZdyN5YbE7FLEHzPe7gt2Jm3wfKv6CDSSt5Id2z6oAWiZ6U?=
 =?us-ascii?Q?hnWjmJNM1zj0g+gzMvC3tBdrici+l+BOrsDb1Wpi5E9A5/sl5xGSqDeTEwfV?=
 =?us-ascii?Q?eO0JIMye7j5GR4mgYR1wI2YLNgk+RjvZ8k6tjViveApb9M5reK6iuG9gclxF?=
 =?us-ascii?Q?nM37OiUN1jKQ5LXWx7F+AAPZ5ol9EG2vOfQJiVDNqloFBGuxJWCusDNJVxhm?=
 =?us-ascii?Q?ew6vEwMBMIntOIvHdniKFbBEQpxJqQqBSLEIZrM14Pzqar84i1xDEjoY/Hd3?=
 =?us-ascii?Q?DXRH5mO/SsoTCAHODTKxo/ZtMAlilb7rjc60M5k8bTvfElh7vw0FCgbOnbrt?=
 =?us-ascii?Q?LPPCz5FP63F7AVWTPr3h7EeUCwjfkFxZRz9zbHkUY3yhB1kzswFwLE28J0nI?=
 =?us-ascii?Q?Pad/yEJ8cSFInTJfSol9d0jHbl1d3Wp+A0WA1dTXixwaivoy/jRV3tTVaLEW?=
 =?us-ascii?Q?D5UX6nRYwIzJs/pp+LLobpmzDGCXQHZygII/WN/yf3kvcZeu9/SDQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2NpbQwUSdBkk4SS4rf8nn8TIdgKUxaJOTrJYX8JuByhNBnnfBMsFhRxilc9?=
 =?us-ascii?Q?+fwiBA2Ew+bTfiDv4aKFffKQJMfUs34TZf4EmkKCQBxjAHy0hcZlAF8TUa+J?=
 =?us-ascii?Q?syHWkHPSmWW/t9mSbfQhOD+6xgHsY+sxdu3azZYIkWnS7iUQi9lf6Qy4KvMR?=
 =?us-ascii?Q?D9iDCwTS/Aau61Bwda78fUPJVcoYhAuli1PtlebSgNXnYvEnl71n4G4O8L1F?=
 =?us-ascii?Q?3uh4/aGK1Wg4H7tPh1triylIW4a8ep0cvWX8bFyO//fdnb09jAD6C/CNyw/p?=
 =?us-ascii?Q?DN1AAEhKdHT0aSoQFi8hnRhVkKI3lVbyxbw+wqic/JR1jLxkvSI6AEvblMb/?=
 =?us-ascii?Q?bcKWZysEz/kVCpFgJlImbv2gG5KaopPokFVU+RQptNfX29OUBhDuaLx+bkEK?=
 =?us-ascii?Q?sD3QKAFRS2ygF7hodS/WQILxiM8es+Ja74NVhyNzpBH1gfeSqDVvfYXpW1MQ?=
 =?us-ascii?Q?SKUBYwRmZJySWtm6pgzcnSkV1nmK1v6DdZ2F4mILhmOKmaZHKkee3mi2lUpg?=
 =?us-ascii?Q?vAotSlGUU60A4TV0pgYcmE+oGkegQcv9P/Hu7YLBdiA50tPWyriI5GHvizhx?=
 =?us-ascii?Q?DJJB7jlMYCBxCKeNaLz/ztgAze5Dfia5mebYgFpbojs7ibG4IJyC6ustP6wI?=
 =?us-ascii?Q?LmfRsDQhz6kAeGWGURlqPGjVPO/nip+dGLZn8dtAYD79C3LoqChXDkX5XMfx?=
 =?us-ascii?Q?RGnYB7pSkN3BjLX0d3Lvn7eU1cmD5yTAh1fleSCtfkQ8pevKKL7xLsBJQgSQ?=
 =?us-ascii?Q?vM1WNiwDOmOxyrRix2yhK5A0EArc7syUMyvlvCW58Hr1eO97wH5yLcuM5Ol6?=
 =?us-ascii?Q?mtH0U59x/R8KSBbsdCnCLLpOEGQoOKcWLJ7I2w0c9Um1tkQ530xNNy5eX/Vb?=
 =?us-ascii?Q?/0WrKTku9UA3cGUCE8XC6lvF8jV4wtQRpSa/toz392pFwI72KusmBzMlioLm?=
 =?us-ascii?Q?nciNazeR1yKJTVJeuUA9WNkonVZyPqJA7/GNma6kgnrQCAZyev2otvOGnoJv?=
 =?us-ascii?Q?EdEKwW8Ec4akbsq/l6VQ5KpUVvMRSM4IqXc6XLp3gvSBUIvwIj0OGjNPhy8F?=
 =?us-ascii?Q?TYfT1B4RgzTHemMUs1icpztHOsY7cuZyJhbwK+tBA9Pfq8yNZwH8drizGeHN?=
 =?us-ascii?Q?5G98J6Yg64KqkVV2pJAOfCWoAVWIl4l1C1AfpE18H2A4T8ScAXO8d0RrcroM?=
 =?us-ascii?Q?KQJD3Fge31dGHqPz8fKmncl1cB4yQ4PEUtoHRkZDimFF22/llfY7yzn9E+WI?=
 =?us-ascii?Q?MbDEenUL7ozCX9qX407Hk8rY1gE7GYquxQgk4tTPbc0KCtqnuiulZW0jrFQm?=
 =?us-ascii?Q?hbZKw1TKYINWNqXy0TwS8/6W5vm3/hcr/zw5O4t3Ouk2al4CcHXTmCrHTcdK?=
 =?us-ascii?Q?yBxiggxSgbwPFg/QoCA6pi4/i4B4FlaAdJjmxJtRc7vXiebRhsIt37LkxtOj?=
 =?us-ascii?Q?8w00eAp7jyqG5b3yStw2eQFxmmaCeMzWcdP6mrPLyMdDwy+Zto3sSBmQx84K?=
 =?us-ascii?Q?p6eaJ+A4uiYgWl+TfD3UHwNPxXFpGzuYiDWt0LUCKNQCCFuUi8Dq2j3Rvf1/?=
 =?us-ascii?Q?XJcxENYj05tRVoCdyi4jwPtuWzExHscpIAL4CEZK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a1f13-e2d1-4176-5af2-08de11ac2cd6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:47:11.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPPaHmB+nNS6GuSZyPqf45++3JBG9FjKDg1ZkHSmin2wN4iP0XQ6mp1PvOfsJl39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

On 21 Oct 2025, at 23:35, Zi Yan wrote:

> Hi all,
>
> This patchset is a follow-up of "[PATCH v3] mm/huge_memory: do not change
> split_huge_page*() target order silently."[1]. It improves how memory
> failure code handles large block size(LBS) folios with
> min_order_for_split() > 0. By splitting a large folio containing HW
> poisoned pages to min_order_for_split(), the after-split folios without
> HW poisoned pages could be freed for reuse. To achieve this, folio split
> code needs to set has_hwpoisoned on after-split folios containing HW
> poisoned pages.
>
> This patchset includes:
> 1. A patch sets has_hwpoisoned on the right after-split folios after
>    scanning all pages in the folios,

Based on the discussion with David[1], this patch will be sent separately
as a hotfix. The remaining patches will be sent out after Patch 1 is picked
up. Please note that I will address David's feedback in the new version of
Patch 1. Sorry for the inconvenience.

[1] https://lore.kernel.org/all/d3d05898-5530-4990-9d61-8268bd483765@redhat.com/

> 2. A patch adds split_huge_page_to_order(),
> 3. Patch 2 and Patch 3 of "[PATCH v2 0/3] Do not change split folio target
>    order"[2],
>
> This patchset is based on mm-new.
>
> Changelog
> ===
> From V2[2]:
> 1. Patch 1 is sent separately as a hotfix[1].
> 2. set has_hwpoisoned on after-split folios if any contains HW poisoned
>    pages.
> 3. added split_huge_page_to_order().
> 4. added a missing newline after variable decalaration.
> 5. added /* release= */ to try_to_split_thp_page().
> 6. restructured try_to_split_thp_page() in memory_failure().
> 7. fixed a typo.
> 8. clarified the comment in soft_offline_in_use_page().
>
>
> Link: https://lore.kernel.org/all/20251017013630.139907-1-ziy@nvidia.com/ [1]
> Link: https://lore.kernel.org/all/20251016033452.125479-1-ziy@nvidia.com/ [2]
>
> Zi Yan (4):
>   mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0
>     order
>   mm/huge_memory: add split_huge_page_to_order()
>   mm/memory-failure: improve large block size folio handling.
>   mm/huge_memory: fix kernel-doc comments for folio_split() and related.
>
>  include/linux/huge_mm.h | 22 ++++++++++++-----
>  mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++-----------
>  mm/memory-failure.c     | 30 +++++++++++++++++++---
>  3 files changed, 82 insertions(+), 25 deletions(-)
>
> -- 
> 2.51.0


--
Best Regards,
Yan, Zi

