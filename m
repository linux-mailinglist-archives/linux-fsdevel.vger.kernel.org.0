Return-Path: <linux-fsdevel+bounces-49934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BAEAC5C62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002561BA4C30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581392139D8;
	Tue, 27 May 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ8ZD5JX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A52566;
	Tue, 27 May 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382425; cv=fail; b=nio1RFmh8xrDEHCNyvx3aqZAfEIDywUJ/gwxIV72KC4WN2JGCxy6sCqNCkKkOKXgE8LgzMuMXp++aDJNktbZ2ONSF755BQxjqrQsZqlzBYmt4Vldstob80EWn8aScqKGqYuvyjLqBkTeT+VjsIVOO5EOpkaKzL+OSsUBveYcb5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382425; c=relaxed/simple;
	bh=I62+3L9RTir1/pe1c6QWZbvEIgCZZjrjHGLiajjVk1w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IasrYemmPa9hr9i8qrEJoZcAc1gerzvD1y5wIso4nnJuSBVheJwHo0jYtLAQtOYBMhSnB4VEErtsdwY6y2j1QEg0Q9YG4MHgqjvjNiAbNqpMrM/BiAXF2dtziBYGv084tOpH8zoT5j2q4RjgSv8Llcx3jl0F358C0VaRilEAxSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ8ZD5JX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748382424; x=1779918424;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I62+3L9RTir1/pe1c6QWZbvEIgCZZjrjHGLiajjVk1w=;
  b=ZZ8ZD5JXaRLHxJQl/jAgJDovKgX2GRTOdaufjyWpvT5JGp9L5Y8GTv01
   tf48aBgndJg7pc2ZgOQiJCXteXYP+wsBRmjHIfcuLLX04U8Wjz92TBAxY
   /FVgmXBJ2ruD3iKc8MqDIyx45xySF52Gxkizt7LvELyiOr+2XYvGGwSr3
   tMSAiQBwzPx5hPeTSdc5FW6RYUFcR57Gd/VepyJleU+6ojvGI7jaViHgk
   GQ0nFNJVtUCItDNpAcs3D1uVpyxPwCpPDsYc8LNWUMNYLSatR8n9ufMQg
   nwP7qA8ovOelRJ50oyD32+Ul6QPRlOSoj9y4YYmEoWk1H1gOEBrEEgXYK
   w==;
X-CSE-ConnectionGUID: qoBrmhLgTkuQLthuIOeROw==
X-CSE-MsgGUID: mN3XiAL5Q8a1TlDfIuOl1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50091184"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="50091184"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:47:03 -0700
X-CSE-ConnectionGUID: gdwElw54RiKKsW0lnqMfYQ==
X-CSE-MsgGUID: 05SyGwHjSZSvbnX8yK+gLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="143447393"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:47:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 14:47:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 14:47:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 14:47:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vD38ktPQpTVzO7DxMh8W8NjUXWvT42ueU/9cMbsZf97fytoZlTIAms2bIArnUO2eNY/CfO8uLsd0vr1zCe+0ifLM8MrHFmcQVg1nMl5bekbXU25YbtY9oVEATt97NZVfBia2H2df8qma/FyaGxo11sADeTRJz3Jgsqd2YefCnP+dy3OlyiGHsO9BkzbeRDlO4Ogt7ZT2H5VmVdPeeXJq9obXv59PorSpnjNl6Yz2fEOZ8KRGkZXM52zkWjBgSvvyJcxnPYduaRp5SsoWk9K4ondRyC2pfFXpnqI+Erry47u41MG943zFtE4wntd6nLhXzfJeamUXGS/iV2gO81wTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtCfB3UVbt+Pa1lUi1anZ3P3R2n/GkQrDrQrf0t9kMI=;
 b=G6GTAPHz9cvp6yyZdaxT8MvAM1jURvJJovqrSoQvzjGDYofH+6b7ihEidRHu7bFNdX/hYEIBt8RLwe9rFe2sAiOdddMeEU2NWwtM8RlYTWv9npzQlEyq94C32AAoc8CNiIQyqLWoWnpy1ZqJEhprj+SUyD2VKbgUdMQwf+fF1p8FALAcKdX95h5aoVy4hVE1NXdUmxlga4lXsknM3T0wjMGO7B8GiMqYhdPo5S9nDCJshpriiZ/yk6hjiOJJ2PXlcNo9pOtQ2ul4hXV2dzE3ZqWdC/DuEwuwk0vhpR3idbANt30lecujCjRXWn1qcXLvIpvQf1g0Xaro4W5FLm/rRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 21:46:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 21:46:32 +0000
Date: Tue, 27 May 2025 14:46:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<dan.j.williams@intel.com>, <willy@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>, Balbir Singh
	<balbirs@nvidia.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner
	<david@fromorbit.com>, David Hildenbrand <david@redhat.com>, Jan Kara
	<jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, Ted Ts'o <tytso@mit.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>
Subject: Re: [PATCH] fs/dax: Fix "don't skip locked entries when scanning
 entries"
Message-ID: <683632b425dc2_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250523043749.1460780-1-apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250523043749.1460780-1-apopple@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b136ef7-cd17-4f0b-2cb2-08dd9d67f1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uj2q5re0EkTEFTtTfeJyI6vT/WQTHca1GYe26jPrO3jl/TrezLRYs8Gi8FDN?=
 =?us-ascii?Q?Ks2OyYOARxNn9AtGHtFIRelHDoZlzxuvJ7wtEcBdP5Ib0TBtrr0lUxuWYyqF?=
 =?us-ascii?Q?4PoIxz5UPaGzgc5SEg5ohiBgJrFWejFt4v1EqIwjtiA77t1I6Uumkq+HTHqM?=
 =?us-ascii?Q?aRB0sHz8OAcIgvaR5tC4u9CRk41MFpXTErmWUz9W02R9oxtk3vmkonIBoZ9i?=
 =?us-ascii?Q?/Y4WN4/wyk8Jp2UnS5GSfviTAF74PAVFX1wzKQpHfCug6W4nffvXIPB2299C?=
 =?us-ascii?Q?ZVRwbmo4/65SY6E6HYpcuOFFZlVNKmEvc6obbHIIDM04fz8O0WRGc4Hh/BfG?=
 =?us-ascii?Q?R/vyBV/7/uJujVWF6eSgPNQ1Ur2n+f9xE/m1BZLptf2lgK4cU50biZM8OGzJ?=
 =?us-ascii?Q?9Dcc8gi+8B1YCfM1GP51GuzEH9A5IdG5vJV61MO6g3ufl3QUl2EKArGQB9fT?=
 =?us-ascii?Q?vnB6+MR2EteQC/wOtzJFCtAIZdrNAZHZSs4qXaz2eQFYGktG3a5LdUdQNTCo?=
 =?us-ascii?Q?aUjvBpmlUN16gx+iWsB7g/cNqfpvIR84ayWsX06GRCwNcE3Mkdotvc7aqP/S?=
 =?us-ascii?Q?gD+5O3zBIjo+gIPSPETWHZolSZGi5XrRGg0AiLoheLQ1icr/NSd6k4c4KWvd?=
 =?us-ascii?Q?J1PqO2Ejg5XqsfaKS4eYcnBVTIRvRgOpisV9h+sS+0tYR/qkrWo9RLMefQ7i?=
 =?us-ascii?Q?zTxN7T7iJGZWRNaraEqGGnt54gOy7Dcxq6dXiWZzXv8PcarBuuN1Ady+HIGg?=
 =?us-ascii?Q?bOe9iAJKmSqW6dazoV8JoRqn+MkzUXP6vJ23naOaVGZeGGlgzW53r12pp17A?=
 =?us-ascii?Q?gKnYLkSkWN+lajDSzXENhjRqf/jwEY454jE8F1Lr3OxGO9UutstoV3X5hqeQ?=
 =?us-ascii?Q?oAuUOAPj/JlMW9ks7q2nRD5dnKffSmAlwKHDGw1uruvrjpU1edSDMUH80yFf?=
 =?us-ascii?Q?SRuQYmKGAYaMctsaEmpYTaXpUE6JMc2AS0NtGia1gZl2+vrbJLFMAGJ9l8ex?=
 =?us-ascii?Q?5eLGmeXXeOJgVPN1HWyCeS0eX8yhdsfauKVZEb8DpmaT0IDhRGlyCWNRHtW0?=
 =?us-ascii?Q?MqVf5GGbyqjKtCFUqg4NvJxwpiQDGAyjb1lQsrjb5Fu9C+GKat3IRTG5zBR7?=
 =?us-ascii?Q?fAfVfm+bPo7yV9KHsDQLUFzks86XcaFwsUhOXkZR/vHSYtpmCN4b+Vw0c8ek?=
 =?us-ascii?Q?7eexOJTwN32h35HwYlhRuZktTz/jZ6cv1UBgmEbVhwLKPEPFYsDdr1NF0XBP?=
 =?us-ascii?Q?zQMSyVhHa8RzIGXi/+t48QFgWsl/WGyp+T8Z+hOmHpj8dNuiPs6Qcf5J6Vl4?=
 =?us-ascii?Q?IUX5g+h2rS1L1yqM2X/52QgrYjFgrKYjXy3WL+SXKYPQGnjgmhjYuPI8kQ/W?=
 =?us-ascii?Q?CkOmlgidwqquTR4+rzbCBHMWvzo1WYf1M7TKhYAO3U42THvrNV2NU7TXer23?=
 =?us-ascii?Q?vdx3SJ+TKiY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LuPFk/94p8n1o2Utr+lvguFl6q9MrF9fgMI4no/OtqCwmfg2Not9hLiQZz7T?=
 =?us-ascii?Q?SntnVDOghjaMxsEMZrILsHTOhVEC8y0YxEYngm0jMF5xtp0y6FXcdJIyVFa4?=
 =?us-ascii?Q?QzIHxcd40tP1nJEOfcam6gfG3haaFMeoKn28ArTJLNgCmbo2vxFHTA6Ay7bR?=
 =?us-ascii?Q?PmNP2z9vdcMlM2R3Hr/9Ii7PVHZDyWQOo0wnPsfofIn0oksLx409Z8M5xVYy?=
 =?us-ascii?Q?0gw2hnwaqnlf6Kreyd2UA/HqEh2ICmo/y56LRClP+pAislyY1/TrjwJYRdo4?=
 =?us-ascii?Q?ytVJeWsqU5danIX8KjomTw7wDOvpP9UzJlbavBNtt4Cr6a5K0IQ7XFuz1Yhb?=
 =?us-ascii?Q?Z7K76pdLESFTZURYUClVy7f2NWTwAMeelbhnHtKo+PelfhEZFf1WsEZFcf+G?=
 =?us-ascii?Q?vBdXSDCd8+qOTHKBTtqUYUMBw+JX41O+lryaNJjB76BPWZESlmS9LCzKsOLb?=
 =?us-ascii?Q?a5O3HwkMoRB0trU2qt+lNT7msDkRw0aDKCBvLupx7j8CxWKHj8AWAaL4X8vU?=
 =?us-ascii?Q?kTa2AXHKO7gH51emOAfBVqJlAHwSVRlMgm/M3xc6nqoPKJjMS9TkwWVhzoaR?=
 =?us-ascii?Q?Eb8J9+NkxnbO9NzPtv7kNpiCtjJmhMMg0A9bBaYDE56nMNDuGMXd2rw8iCed?=
 =?us-ascii?Q?SV1IgjtMEUnpPB9g5S5mPX6/rtcAeEIEXTK6ZXCS2/sB/R53ii+5SRJegeMT?=
 =?us-ascii?Q?TB/jSuxFsH2tPeB3z5tdwkUUd7OPFySvXOn17HBdSCX0v5TeBmCd56EOlSHr?=
 =?us-ascii?Q?AGI+kM+lL8sDXIOr1VaJheOTjCG9RXj6FdsZ8MET1Do/QOWF7pAIK3exPuGl?=
 =?us-ascii?Q?+3eBLzeMyUDGcY9KgltPWW4VKbC4ReUj9b+787WEPwJfcBOmMuIyj3t5GTQv?=
 =?us-ascii?Q?67pEjh2gWLFpdlIRtaP803JI0HPkEqQowiwwF5KKcX0YIuF7YJ+eR2fprLuG?=
 =?us-ascii?Q?WFC1Y+8X/FRq2XwYBtb/qa4/L3fAZoe5pUaVKzH00SeJvHe6IQ5Wonon9vpg?=
 =?us-ascii?Q?UvWfO99mn+5lOjmR7msaPS66jKuNEffFnwLEcvD04FR4yaHkY4IcsvkvOUka?=
 =?us-ascii?Q?9uwhe+bEkhxzjshZprq146a/jrJFi/Tbpqb0+3fNYHgczduhyF8mstzAgXe5?=
 =?us-ascii?Q?+C8UzWUlQOR+W1mt8Fmzkd8yVvu5V/GCS8uYMomgTlZUw5Nn0C6f27HdGRJf?=
 =?us-ascii?Q?M9PfQ3b9Xt/bFRCU4N2JcNK7Ewr0qZBdkiOzyPHplspHF9ZaQfDSEEDUcibO?=
 =?us-ascii?Q?kjctzK+0eGbvdoG8I4zUUvZSeSX8RAPa1ETbHjVctM5qUmMXIXwfWuaYyhUQ?=
 =?us-ascii?Q?ORrTo7eyPr9dLkntxF/U/gNBalp38Q5CYiajCGm4g5Nk849TZlerfQfyHOZs?=
 =?us-ascii?Q?Tp0hKFytlOjmjhQYQGjrMmV5czs5ib6+pueId6AuVNvo/yMuyqKVPi7vJ253?=
 =?us-ascii?Q?GFA67BvKjrNMLv/Y4sHLJT+dyJJx1rn56GLm3gPygrn8cR4TdyWC2pTgzAMb?=
 =?us-ascii?Q?//vHbnDlYDupT/RQ8pripaYCtg08+JJExYY27gIODy3Dfafb6x3cNW3eUpM6?=
 =?us-ascii?Q?Nm2GBjelyToVCHXyYZ/saqam7PA8lg9/fJLYD/q1ZWqkbOOa787icbBpFrvs?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b136ef7-cd17-4f0b-2cb2-08dd9d67f1b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 21:46:32.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XK0Dhz+D05CZErCNJC2ZJiHQU6cuPtGnM6OTWJYfHQShs31LfJTHCDRPFf+Pv6iWr1WHkFIpy9JbGOoVHD4GsalNJsYvbpdOTv2x7pKcsX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Commit 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning
> entries") introduced a new function, wait_entry_unlocked_exclusive(),
> which waits for the current entry to become unlocked without advancing
> the XArray iterator state.
> 
> Waiting for the entry to become unlocked requires dropping the XArray
> lock. This requires calling xas_pause() prior to dropping the lock
> which leaves the xas in a suitable state for the next iteration. However
> this has the side-effect of advancing the xas state to the next index.
> Normally this isn't an issue because xas_for_each() contains code to
> detect this state and thus avoid advancing the index a second time on
> the next loop iteration.
> 
> However both callers of and wait_entry_unlocked_exclusive() itself
> subsequently use the xas state to reload the entry. As xas_pause()
> updated the state to the next index this will cause the current entry
> which is being waited on to be skipped. This caused the following
> warning to fire intermittently when running xftest generic/068 on an XFS
> filesystem with FS DAX enabled:
> 
> [   35.067397] ------------[ cut here ]------------
> [   35.068229] WARNING: CPU: 21 PID: 1640 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0xd8/0x1e0
[..]
> 
> Fix this by using xas_reset() instead, which is equivalent in
> implementation to xas_pause() but does not advance the XArray state.
> 
> Fixes: 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning entries")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
[..]
> 
> Hi Andrew,
> 
> Apologies for finding this so late in the cycle. This is a very
> intermittent issue for me, and it seems it was only exposed by a recent
> upgrade to my test machine/setup. The user visible impact is the same
> as for the original commit this fixes. That is possible file data
> corruption if a device has a FS DAX page pinned for DMA.
> 
> So in other words it means my original fix was not 100% effective.
> The issue that commit fixed has existed for a long time without being
> reported, so not sure if this is worth trying to get into v6.15 or not.
> 
> Either way I figured it would be best to send this ASAP, which means I
> am still waiting for a complete xfstest run to complete (although the
> failing test does now pass cleanly).
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 676303419e9e..f8d8b1afd232 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -257,7 +257,7 @@ static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
>  		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
>  		prepare_to_wait_exclusive(wq, &ewait.wait,
>  					TASK_UNINTERRUPTIBLE);
> -		xas_pause(xas);
> +		xas_reset(xas);
>  		xas_unlock_irq(xas);
>  		schedule();
>  		finish_wait(wq, &ewait.wait);

This looks super-subtle, but so did the original fix commit 6be3e21d25ca
("fs/dax: don't skip locked entries when scanning entries"). The
resolution is the same to make sure the xarray state does not mistakenly
advance when the lock is dropped.

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

