Return-Path: <linux-fsdevel+bounces-72012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE12CDB2C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 03:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AAB13032A82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD93274B44;
	Wed, 24 Dec 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nx4Ugnd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FA19B5A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543179; cv=fail; b=bcbrlEZMIIbn5OEVExr/R96KcYL4MA7dw1bpjYnEE9ky/W4j1QE3G7kZILiy4VqzFjGjg7AH/dk361ySF/eloMq3xByzWXsPg1cX+UCU8OCO7yYYTlwL/i62p746cQoQhZ2j3NgSLJ5qJ2h61cFXI6i16Zg+LfQ7iUOWDEu1SKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543179; c=relaxed/simple;
	bh=TUByQd2CT+fH0G95obD+JJQepNPpPBPqwz/96mP5ECk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1eSI3OpqJl0+30r6AmeoK5GPhds/yTiTcOYbxu4r354spOVBt7mq/oeEk1AKz+LwkIn+V52KFFVFQ0bSn90RvLCojKZwd/GMd/xldzcqVuYhQU8FHRqHGxHmhXhyT4e9ztNErkpIluB68Jb4sqzdn6ChkIq8ngq0ReuMy1bOxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nx4Ugnd2; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx5Rzuwjo/Xh5/W81OJIHkx3oMT6JVmcSoJpAchShZK6p9y+WKL7bX3R1ar7XWQlL9c9z3dasVBXEGzSqiggqx0Eyt+oB7py+gUt4bHAwlaoHEZkJuTbeHcv7RNSvcOTPtgbIERT1VD+umcD9JqyNT2UjZDtHt5ByhBiIosMRtiXSmtlNOth89I3yoFIeH1Pao32PLVASDOenEns6/yj7KZ3BACbAsHSAgbIVCM6z3D7jtZh9P/n7TjieyS53eGpBC+JGBI9LBoNa0UocLQz7ZGI6vJfGHPAJ7YtEOaVHXGU5fMkL2E/AAkTyAlKkrHjIwCeIIGvgnuaJAKlVknDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe971I7vctGicnmZN3rn6GUUD9cdSqx5fnZuxG5VU50=;
 b=YNzL55AkTxP8JEXPBGkE6UPwTILPmz4smZxzWIFKnaVr+f+oN8T8H4Rw8yDhsqUA9bGRab61gqrCDRcAlM38YmuydFq3nlX+iaJjq8ZeYQhvDcQq+9WJXC+WOx8yWW/MnwGV9tl564eCdyPQFU/dVmDYwns9YekydQ65TqThiDCeaJ7FJIeC7iZAF0tKWtX8VqYr8bVFty0oxZ/YXVtZAs5Cw10c5rDKiXLOrbabXDrffigw4CdwFUOKaiaCWi113A/dfMYoRePfiu3f+5sKmD6FNjEV8mtXPTT99rsVM29djYsL5uC7en+7UsG140A2GdX5runue/k1RHEq25Xmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe971I7vctGicnmZN3rn6GUUD9cdSqx5fnZuxG5VU50=;
 b=nx4Ugnd2xEPHsHecTCKT4saQNpZ2+oVL9/UgZiEYQtJjmo6V1FUtC5c6PIm4SFtF6GC0zqmVaBdJ2yFRW+A+B8vCTdRKP5TebmGYDYm9pCdlo9je1F2OzCWKIV90sGRwn7zkcyhwHWe1zF1xK8fmCx0JQER3SVe2gyV6WxC1kqFvhjSuSaFaE38HY3LsKlIcpX/ZlhR83wpb6rlhF30rm3bsF7tLtjCbUwehTuY0uTEBZcEJEkg6rK7EmNPUmWo8lVafVCpTE52N9kZRRXFLekTnsnCmqT75W7Jb08BIMo3+olGXyiZOaaiKrcX+TdVmcph4vyaSeyF5OYJcEfkdbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 02:26:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 02:26:14 +0000
Date: Tue, 23 Dec 2025 22:26:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthew Wilcox <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH 3/4] ARM: remove support for highmem on VIVT
Message-ID: <aUtPRFdbpSQ20eOx@nvidia.com>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-4-arnd@kernel.org>
 <20251219171412.GG254720@nvidia.com>
 <513078d3-976a-4e6d-b311-dcfcfea99238@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513078d3-976a-4e6d-b311-dcfcfea99238@app.fastmail.com>
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7b1b12-71fc-4b54-3c06-08de4293cf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfGIOQyH14URNgZzvp0KfG1PHBbKMeDHkpBMBq1b6fLft2MbXrU9HhhHviZ7?=
 =?us-ascii?Q?lgl5xMlYRG3aedouznpV846rSqfCbMXmC/uBswWj3fXMfQ5C3gjU2mywVof1?=
 =?us-ascii?Q?JgUFzzlOY3nG42mP029e/XyxY7RCB1YLIKsf2Ajhnh3mqltuEhQXVaxDV7tD?=
 =?us-ascii?Q?wmrp2aefHiEpfi7cBG+JhLLAMS2gr5stCJqcd2VtpY56ihAM0Vmu6yjSMZPj?=
 =?us-ascii?Q?rYOZYfrGvGms3eO3PXrofnISNhqUmtTBHU3JHD7BqhxMMSHzLTaa8ueTIm+z?=
 =?us-ascii?Q?Ki9JVeKm3U8bIhnp368zIzYw4PtupZOXGsnA3I3NYjR60FFYjEw/sEnrFEVc?=
 =?us-ascii?Q?K7+f8lrCoQBQqwlZ4rnr/Dn4fp89whZz43TNk0qNjyPbt/EBZE+HeDssay++?=
 =?us-ascii?Q?W+bGMhFZo6yWb1Ots3mdLdG/K4mDOJfVwNKRrInDgG/to7tc/pxt5fgfZEyg?=
 =?us-ascii?Q?oYjscZP/FhLRO0J0fwq5DfHMjNDQ+wsjtRcNWa3/j4GjE2WPBc1bkjqthy0Z?=
 =?us-ascii?Q?gDdUTTzB0rg1Ct7WKwyHXn7ag0kPtt883uGxjdX8h6uUexwWZ11Ms6VBTpVU?=
 =?us-ascii?Q?CmKwZWRUIG7LwU91dBiCDdORZDyVw44dUz37etehgduIy6mzzyVrHnNAPJpI?=
 =?us-ascii?Q?1QAYUMKpFzbtXFFawrQaOBKyhcxCy0+aN1muYcKRWVCx+O3eehmU5kx1a3m1?=
 =?us-ascii?Q?t6YhGBEn5EUb/mEOUkR/3WuHfYgTzrThZvYqoSu6dFxjYzDYuPHLheMVAN7C?=
 =?us-ascii?Q?aKO/hL4YlnmBFaLMAeHASMXYO5rxPHOifxnDLaBvfy5tWnYOusRl8acQB2U7?=
 =?us-ascii?Q?Sd8p68j6tFcJG6QOLpgR9RUdadDs6pL+JLxtbHSFrbHyv5Pns+R5nFbPVFfi?=
 =?us-ascii?Q?vo3pESHNUqv5t44OM7vLjRXNOZy8ujpRlgR0NcrxaUsYbz7DoMy79L6T53g8?=
 =?us-ascii?Q?MITx6FOmupGlSa9As/lcPNBIBErQqe/1bZr95MwYlJFljPWEVEv1lnlbRJYF?=
 =?us-ascii?Q?fTaQNWpSTjL0fdaCJgT/ccGak0gumrg9l/pqzUBOzZDnd1/eqLN590ePfBSZ?=
 =?us-ascii?Q?DZUdEXs6+Qmievh/dH4ZQEFkOE++g7B7s90ErE2ZVwdjudcsqCJ4RDzXNLhx?=
 =?us-ascii?Q?+kHAs50AlshMHKnnn+62VsUR6ez+4a7xD/sKRN3KyXNI7Y6Glnuk8yo5pFv5?=
 =?us-ascii?Q?on2+lWrsBjYiYsDIQkKyeznfFvJ3q5/4WQIOsJCc03LX06aQSRBpbugB7XEz?=
 =?us-ascii?Q?eBf2LvBfY+ok87zlaI+/zyaddoz3E8OGaDZMtu5ehyt3wvlz4VODSUMDmyGD?=
 =?us-ascii?Q?YECauAjRmA3TAI7ItBfMxRh4mxBeJjBHxgcD1Nb2oieTpXP3vU8jfADKfdae?=
 =?us-ascii?Q?BMYR5dKI1e5U40vTeEgfXhBdyDhHtxTe/Lu87YibrTep8B4PNpUYGTkcS/C2?=
 =?us-ascii?Q?hY1y2dSL0o30bVL/jKgexveyi5PPaWuL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kxDzyl/dThwRaEXpYXkNI7XExGZdFars2UevTeolxu1Yiz9Zv7JQcC9f4/2?=
 =?us-ascii?Q?J1WbfGzFW9mKItjtKzSbNzhKC6uV7SO2ev5b419Hd2gVRvEl/CCKtB3YL9js?=
 =?us-ascii?Q?YOV8ggsbTqEUrF2VBIMKHtQl/oSpV64KtNl+zp56rsYGFUIPoNaZuTgJ/GHD?=
 =?us-ascii?Q?cWDa2LeMQn65EeXLhzboPOhX5p6f+DPBsZoyfzhSK6C4KK4HFyQY5KLvtuO5?=
 =?us-ascii?Q?Lh7kv/qwPRa/AQJ1hYcF4GTPv1O/5UCDMPqoiwxXILWch4/i0q9XeIktZODA?=
 =?us-ascii?Q?v/tEj/EV+htVTZ/jksA0kD9dI39TAPoMvCdRQKNYYtomY3gsrPCA/kSUZXnx?=
 =?us-ascii?Q?k6lqRM+kLRXQHtiPB9LnM4C96M5MYch/T6TN0hYabmgwbzP/OGdU2VVU5jdo?=
 =?us-ascii?Q?OjbEJurAew3WT4+NNYduyeVeGoUKmVOOmCNf2Nb/dwE9rVtifSYGaNPqCICr?=
 =?us-ascii?Q?dahkXAM+8jafixcjRVVdzohCxBGtNGedwphSW7Oy5tJzwbfuk+jujkSbIMfg?=
 =?us-ascii?Q?wD6mO0iwG8uGxLUdzBWXDAPC3qV0fAuS7VLff0dCXBKGNO1mI9IP4nggpnnk?=
 =?us-ascii?Q?AhLxHZwtE1QJXSJOFvU+Bs8A9znbbijps+vZSYhrd2WciT8WB7kK0VTzafb/?=
 =?us-ascii?Q?f5jxkYZSARzDuoDUq1cjDkWd4jAq/F4ygvbvJE286FS43d5Sat0pfpi6fHnk?=
 =?us-ascii?Q?LRO9B7PYxM173eFg1z/1AfCJitPQfoUTfKXk3zvA+3KGW/uYcf8YpG/zRu6H?=
 =?us-ascii?Q?ey2jJPe6KKT+qSG24wqr1YsYjd1anD/UN2fKRmUJTjqou6BO1V6B77XRQVlr?=
 =?us-ascii?Q?Q38lpcA43YDnDsj+ILtwO33T3B3OdHUSoEq3Y8XvyCLYiWJPr7qu8RvYU1e0?=
 =?us-ascii?Q?n9WqR0eF61bczo/WXcD0CgdVQzfWvmsB9u1P3/ZzJIiuhaUa81uOydB+itIh?=
 =?us-ascii?Q?1IJS0lnLfUKjEtsdmLccwn5NETr3Wq6iFsFv5iAKFjqEWqJt3vuOC27fAEic?=
 =?us-ascii?Q?6qSPcyqnzAS364NbicyXecAJBP+dshZXZPq/DKCeM9UAN80bbR9i3Kv9GwbR?=
 =?us-ascii?Q?sEjuJ2Zr52O7h18vV/jUtAArF5t5gIIztIEy+mHkQco7D3QaNsSCOsuZ4qKv?=
 =?us-ascii?Q?LpvZCU5TtTFbD6pFYo7T3wObJETFNsvVnRRoy4YnqqKiiHWKEMOkOuDzQtOf?=
 =?us-ascii?Q?Y5wREG3AWtgxpcGG9U3v1K8XskL1Pe78IZe/oaRi7CLp52rloFpRA3Cj1mQv?=
 =?us-ascii?Q?tVvMFwAiba471RpS/qFVAyG6vw2yldirnOZmFhYbXU6uYkT0ysSO9qdht8I/?=
 =?us-ascii?Q?R0yXwsGRg1HBxr13jwIf+VSTbQCzX+t3gtCm8jmB4yQ69iZYLGhuhI7v9z1y?=
 =?us-ascii?Q?CIbYuY7Kv0H1fDt/zt8hi2U/DDIkl2gMubYzK3LowIG/ooJkycsNBr3jABdW?=
 =?us-ascii?Q?/ik0LdZkoN+tQbf8AIvJQnyEZAluTs2GbgwScb4RkhaNidTUy6M6DNWQV7B6?=
 =?us-ascii?Q?tTcUJIQ47pUaBkHvC+VdXtQByZt+TmZT436HK6tY2FE4aim2C1cv2ZQWteVx?=
 =?us-ascii?Q?ZqwbyEvGBflRs604h5np7NBilfQkGulvM1bnuTC7PY8+5MayayyNqqIcYcpd?=
 =?us-ascii?Q?fBfVMPkovoiao8Z+1kbM31Vg3QNzCl3Zv8E3Ngrl2pXqo5L9+Svtk8jUpjJb?=
 =?us-ascii?Q?t26d3K5IXFHTy+XJRSKy1OKEtwOMYisyat41YDkbpAErW4p3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7b1b12-71fc-4b54-3c06-08de4293cf5c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 02:26:14.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjYlyjUNBbQQd5TbjlAYcVphkB2MfhTVRNVWJpLTdWY0PTfXg+LwjlQoWivegRge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

On Fri, Dec 19, 2025 at 09:34:33PM +0100, Arnd Bergmann wrote:
> On Fri, Dec 19, 2025, at 18:14, Jason Gunthorpe wrote:
> > On Fri, Dec 19, 2025 at 05:15:58PM +0100, Arnd Bergmann wrote:
> >>  arch/arm/Kconfig                    |  1 +
> >>  arch/arm/configs/gemini_defconfig   |  1 -
> >>  arch/arm/configs/multi_v5_defconfig |  1 -
> >>  arch/arm/configs/mvebu_v5_defconfig |  1 -
> >>  arch/arm/include/asm/highmem.h      | 56 ++---------------------------
> >>  arch/arm/mm/cache-feroceon-l2.c     | 31 ++--------------
> >>  arch/arm/mm/cache-xsc3l2.c          | 47 +++---------------------
> >>  arch/arm/mm/dma-mapping.c           | 12 ++-----
> >>  arch/arm/mm/flush.c                 | 19 +++-------
> >>  9 files changed, 16 insertions(+), 153 deletions(-)
> >
> > This looks great, but do you think there should be a boot time crash
> > if a VIVT and HIGHMEM are enabled, just incase?
> 
> Do you mean in the common code or just for Arm?
> 
> We could use the Arm specific cache_is_vivt() macro, but it feels like
> the 'dpends on !CPU_CACHE_VIVT' Kconfig check I added is both
> safer and simpler.

Okay, so maybe I'm asking if !CPU_CACHE_VIVT then the kernel fails to
boot on vivt systems, maybe it already does?

It would be ARM specific, all this stuff is only for ARM32..

Jason

