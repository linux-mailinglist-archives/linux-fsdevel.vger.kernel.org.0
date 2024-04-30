Return-Path: <linux-fsdevel+bounces-18365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDAF8B794B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3704A2812F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF11C6604;
	Tue, 30 Apr 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFQd5xg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC91C2334;
	Tue, 30 Apr 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486501; cv=fail; b=c4H4yp7bwuRjGUJSepZ2lu1H2MvMuoyX/QIVGw+qJoziDO+PwxWmMk0oiniTH27jhGJ6iGHKhn9h3lUJPDb/6boAQbIpjeSO/UtAjZRl9SmaF6aL3u/o9ZDV3W1Xr5eOop1mkfuVUob6146xp1f+1O7T31JBvGOBZsX9FmdYIvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486501; c=relaxed/simple;
	bh=BDlf49uyPbAVhVKKGIyYKpD1ndoXhjI+0SXxPVjGlwg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wg5ks1pBNulehpKIyMn/ajmQGMuzsW18zzIxednWXfCkuVqLv7e8tBvLXTNNT8A2NYJbizEF9s74dpAPd2++OWXDRhmvpB75VufxHfOVpKSaLVE1shnzf9LCOX0j8Q7PqkENObJL/hHB7xT6zwLvE4A+V+WUdGMT/9pJFaLdhSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFQd5xg7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714486499; x=1746022499;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=BDlf49uyPbAVhVKKGIyYKpD1ndoXhjI+0SXxPVjGlwg=;
  b=IFQd5xg7q5RmKL0pDvSPVZ2JCQnX0aYwjCJRdREMONk/yDKwNBzcVbKb
   SElBteSG9gAUZygkURY2sI/M4Jvh0NMbbJOkWdPpvvUsOR77ZxJo2ExL2
   lz7KF35nwLp6xiA8KfyvGYlfXSsEGSte0T2zmomsOMb38TrhJKh48FZls
   5hSRWGRSBN8mdT4M017X3EqJjUYTsZe6ro32b+GC+pMI6ArFxvf9cblfp
   PSzhHe+QePVRmigLX0dH370XACLzMP9MY1JTgDLbyPXAgOIKhcAsYi6Ae
   ENzE0oEbgFEFCO1ZbQJ70p6mNFp7Dp3c6rgoSG5P6n/4+EAgneyDN1kgd
   Q==;
X-CSE-ConnectionGUID: 9j06lm+wS+aO+f/XLIQ91w==
X-CSE-MsgGUID: 4O/RGqyETgOwnsKAcqyIsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21615091"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="21615091"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:14:58 -0700
X-CSE-ConnectionGUID: l23TASuXQoqaK+9iWyJWvw==
X-CSE-MsgGUID: 7kJ/TKDBShaBVr1aE3YX9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26469768"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 07:14:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 07:14:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 07:14:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 07:14:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 07:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca3JeYpcxgQx7yyeewofMWOtyc2E8xUec6bWPIHCKWrrbkV+8OU5pBZO8Oges21LaY2uYTxgZs1CQdSZmp1StRchnj2vX/8vAsyesL2diGH+joNeBGz0x4ciz1J577NfyigiOQsSxp6g/FY3Vb1er3G7pYnjJkWktsIooRlZ/2cUbxf3s4y7g9mcKKEJyEkr6oemS3FWjhQOiucuJWYk10agNnxEZDpkpSL1oeDgwQ4LLQwobrfmA8dQHfiudE19Inkz6d8mESh7UMIMhtsdOE6rt45iJipmpdLbUSOK4zg9fSYfw/w5+mHIgXiqovYLWWRFBPyIYZ8hDrLsQ20VSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhKM9R6NFtcQOUUb8KTIjyOvHB436akQuvsphI+bNRk=;
 b=fErmcou/KCeUddsSpFiDFzzjIMJ4aCuOocUZB905xZ0USX18JLCBOGKhVd5XR4ung0UTX4YgN7Ec0J0gRB9O1yIYva4m+MOj0JmApESlG2ze9gocMrSYwRGamWSR4QdR5AQoHo/avz/uadWw+OwyFAfwc6g2oOIFxmNKNZB9t+tyw3bWjf3l8eTWV5jhazSaIO1X+ODE28MH8zW/pSU8w+72pRo8n9lLgxGUHERhw9Sj18obM0OZk1q+6M897Z3NCrFXfbkUlchlF+oMg1urQUuNseVy7X1pew4nplQGGbRdPW4Kic1Xg+PIJqaWAtZoaHfd58/GgsVYCnDB8ldTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:14:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 14:14:55 +0000
Date: Tue, 30 Apr 2024 22:14:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lucas Karpinski <lkarpins@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Alexander Larsson
	<alexl@redhat.com>, Eric Chanudet <echanude@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<ikent@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>,
	<oliver.sang@intel.com>
Subject: Re: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <202404302220.f8959d4c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240426195429.28547-2-lkarpins@redhat.com>
X-ClientProxiedBy: TYCPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: d16861ec-e285-4893-1f99-08dc691fe8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7D8zeBtXbztQ8myJpTkY7ickBhPdORk3pe06FleBjn2h4oWS4llOsPtkBnb9?=
 =?us-ascii?Q?3RA8C71ELl8uEjNoDz9zQZkmEOigPUAGImfNNDO5WHdDUi/Vih2ujCNRamSk?=
 =?us-ascii?Q?TdCn2DC5WlkQBYKz0pMorF8R4Fe1fNqKil3x6J7P2o9BgsCA7JV2MzjzNB44?=
 =?us-ascii?Q?zE1HGel2p2Wk7rq6XQ2eFahl55o3enzVuDNh08IQO99+2PpmFS/6JH5/9wMc?=
 =?us-ascii?Q?IW2efFmjnL+sU1ggV5tsT5TGh+y39DCPBr6BnuM+HeRmi8O28G+c4/oOI8IE?=
 =?us-ascii?Q?XEb9U29hQcpSsz5EZOYt53JPbxiys27u1ZGewz5PapcesSqud4yQCX8QfV9s?=
 =?us-ascii?Q?JJ+cNaPrsyBrb2b1/YPnnvJ6iNdpbokNJNq5/NSOwxuNteXjQHMCf+4/EmxV?=
 =?us-ascii?Q?z+wD48eAXZIpWIgjAUI1ksMGVpC6zfRPcu002sIQHJlydsQp351YAcVXnE97?=
 =?us-ascii?Q?YJ2IX2ng6HrUfeVFrShdOwlVznslu4Qbav25C2ZUMgzEhkYO4tstZ6hxLrWX?=
 =?us-ascii?Q?J1fNooUeGtgMPb7Yy5XOUO62GtH5nzmY113hpGC+2QG9tZi2fmi7/rHKHaM0?=
 =?us-ascii?Q?daHUd0jgBa6wlp7G/6oMoxLTLNsLqHenvGp71r8yGos5z7O+OXi0wvhz7zoc?=
 =?us-ascii?Q?CdiYlk+Repf/aewgiZBo/JcyGtdCnKXX5mAeS5d/JWKoTKIJpuRKqbs4MrCK?=
 =?us-ascii?Q?6T6J/fIXStD+zkECSGpZEWbQByq8iaPpdbVea7fYg37EdvBi83FcZweFSt0A?=
 =?us-ascii?Q?eXjhjXSncEvPOHUxdfT155ZP8TFIaS79BuIABDjYMl0jeWd99khZySWuzV4y?=
 =?us-ascii?Q?vHZQNaSBJ4i7/KsRohtZrE0jYgRnS7ShKHz/PlA32Ut0to32Wcuzl3K9+t6q?=
 =?us-ascii?Q?A+zwsEIZOHmSCpIk5ieclQWK9tD+mdmQwJaWaw+sS7W4ZfQ7EHAgLMvtjzRZ?=
 =?us-ascii?Q?kY97+DUnvK3xOJey7lKZg50GCVP+IeYEjNDTYtbHW2nKIeOE6zYW88QlnH7f?=
 =?us-ascii?Q?FtbIIK5v1Whl5j/8smZxI8d9is65iDCRtnl5Cr1hGVBIrJ9XqJaXzdsQo67a?=
 =?us-ascii?Q?r3Uqf6ahwnVJpLxh7dn8dJHlkIlNa7BpF4UCn5LoBn/mKSyHRgkls6nGXn1u?=
 =?us-ascii?Q?acQK6PD/ODfuUcSxRV54SAZCbSlp9Un5XvzhHppmr1uU42eqUWXjm39kGqJW?=
 =?us-ascii?Q?seJWMLtLSk6oQmCGvuGEVFjpFfRQxbXliBuHnhd9D8EdNCxIMrH2rYvV/n8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2suIfTHfQTPQBiz2ovlKfvC7GZO0mTo/fR3jstzYyT6oeKaOZ+eLQy0mhIh?=
 =?us-ascii?Q?OovpweFDeIimbdc3F8toWV58k9WMDqGgCzACZ2jBmhOlXuoeDIN6PDYJn2Al?=
 =?us-ascii?Q?jTGE3WconNXkCnK+AIcSW1dhD3QmhL/v0ziA2aifv5peBq+140EgjbB+OQKa?=
 =?us-ascii?Q?ywxfLY/LN5hEPm7pw0qssb1u49PTEpcLdfXO08BN9f+wQ9MzjE3vyN6z6s1Q?=
 =?us-ascii?Q?Rb4oEzXdrqpuw7l1HPRaPbeZz4NKakwxp32cd+DpLy3kJpeN3wXp/K6qcu1q?=
 =?us-ascii?Q?6I3rM4azfPMgdMorYK3URV0B/xkzL/7HSI925AEEibil7YLK7FMMvzkza04Z?=
 =?us-ascii?Q?OjzvDODUOJZmUbxqP7L8LUx98OJgWEG3ibUcJHCpN6GqZpEZjCSjlSCS/MhY?=
 =?us-ascii?Q?Sp4/JBvX/e+dlBpVr06qfhUfoJXcyqStUQiwagvJRHmy6uqKxGgScVUaKqbf?=
 =?us-ascii?Q?XtJNb3CFFKlU6Cde0V+pslNrsittgkAUpeFWNpC5iGrH4LvyY3tK7e058d/R?=
 =?us-ascii?Q?xPkoJEVAcjnMHSMyieDOstFy0SBE9lLuYIa520JLbRlU2pg8iKMudULBi0or?=
 =?us-ascii?Q?YtTWszQNRkqrxEjF0pL8Oty7SswY4h47AjFQ63Rda9XyNwAQ66GmiT2hjUnI?=
 =?us-ascii?Q?mF6SF7jOudfY7uIMNBg7sK/WKWBKdGN4ZM1QR84CH/mJ8Ihn4p8J7oNcK4GQ?=
 =?us-ascii?Q?ZWdCvgROGAnFIASyDhw0qYBPSiHolDBb132EsW8t+Q9oTnY4k69ZfwgBM1iy?=
 =?us-ascii?Q?xhLAtivY5RTVl0+aNFk1VspyiK21RfIglwWN/jXqJRZ6y/+S0H7RIOMBzbt3?=
 =?us-ascii?Q?371JT4gmjKrnwqscPwOHPZlBciXTHNFeRFx/3bevg49TNGi9PAXWzdWosaWe?=
 =?us-ascii?Q?CGc5BRZ6s4sJxSkZuxh4cEYGEQhy6jre2tN2yIWFvBcN6BbxzC6dTh+HPaqQ?=
 =?us-ascii?Q?iU+yGuZFAwZftEd7WX+DGhl2Vn6fPUP4vhAIyHeidPztu55olvznsROYTJIo?=
 =?us-ascii?Q?Znbn7tvQ6PW2Vpts/7pIO2ttP4dNZOMMx2iDg2AHFuQvXredUSmSJrT1cwIx?=
 =?us-ascii?Q?Q+O1Cddt2hd04d+OPqvd0BKxWW9BIikNFwqXEna9UH+Bi1sF6w2vYlUx18cH?=
 =?us-ascii?Q?tfoYSyo5NLXpPA9t6iZgVsyKIrTWvtPl3HoYGcgXymGaI5PT1QY3ZchZ0ysy?=
 =?us-ascii?Q?m1NZoexdl+ywUmidNH/xZMorPhG7oT9qUXu+4m7L6wuwyvDrc2SO2qkPYkXW?=
 =?us-ascii?Q?v4ZndfStixFaeWj9EiD/B4AXEWrABZ8s95pg+WTQ7269SyrVSFI4GHkNpZS5?=
 =?us-ascii?Q?jieB9WUd57uePu7Cw5EWrNcA1jdA2YKA6K/VlEoqKkDBH4KdM0AUACfouBLx?=
 =?us-ascii?Q?3il+/N4K/7pYOUP/wwESFPa3TqiKPOSNlZp80RPH+Xi3fpAMtqDSZGNqwZMc?=
 =?us-ascii?Q?m/q8DE57KEbfcnpnyro12QWOVwpO9dDCnUxDeFqcagrQig/4/pIpYxJyy8wP?=
 =?us-ascii?Q?2/j4U3diUjueKVzmP/IivpWrcprpms3qFwYlmXDrfwFeG3CmJWe5oizmvWtx?=
 =?us-ascii?Q?o0SKswWQcQU3ILyHJp5wq79uPKfCPtMMPBQO1mw9IVb0uyY8xeLRrkVqApfn?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d16861ec-e285-4893-1f99-08dc691fe8bb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:14:55.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4eX6nMNtrkXL8yEpMpvKTnLwjGjQIKOhpvMxprHWVdJKjVN2kSPYgiCgCxZR/cpuctKIksofGHFYmMjlLi91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:inconsistent_lock_state" on:

commit: 9a4131bb20fbeb5980c3e21709488b9c4ef2eee5 ("[RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount")
url: https://github.com/intel-lab-lkp/linux/commits/Lucas-Karpinski/fs-namespace-defer-RCU-sync-for-MNT_DETACH-umount/20240427-035724
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20240426195429.28547-2-lkarpins@redhat.com/
patch subject: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount

in testcase: boot

compiler: gcc-7
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------+------------+------------+
|                                                   | eea3260250 | 9a4131bb20 |
+---------------------------------------------------+------------+------------+
| WARNING:inconsistent_lock_state                   | 0          | 12         |
| inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage   | 0          | 12         |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404302220.f8959d4c-oliver.sang@intel.com


[   19.407878][    C0]
[   19.408164][    C0] ================================
[   19.408629][    C0] WARNING: inconsistent lock state
[   19.409083][    C0] 6.9.0-rc3-00075-g9a4131bb20fb #2 Tainted: G        W       TN
[   19.409757][    C0] --------------------------------
[   19.410209][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[   19.410777][    C0] ksoftirqd/0/10 [HC0[0]:SC1[3]:HE1:SE0] takes:
[ 19.411306][ C0] ffffffff83066cd0 (mount_lock){+.?.}-{2:2}, at: mntput_no_expire (include/linux/seqlock.h:469 include/linux/seqlock.h:495 include/linux/seqlock.h:823 fs/namespace.c:114 fs/namespace.c:1314) 
[   19.412072][    C0] {SOFTIRQ-ON-W} state was registered at:
[ 19.412574][ C0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
[ 19.412999][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 19.413421][ C0] vfs_create_mount (include/linux/seqlock.h:469 include/linux/seqlock.h:495 include/linux/seqlock.h:823 fs/namespace.c:114 fs/namespace.c:1122) 
[ 19.413862][ C0] fc_mount (fs/namespace.c:1134) 
[ 19.414246][ C0] vfs_kern_mount (fs/namespace.c:1148 fs/namespace.c:1181) 
[ 19.414713][ C0] kern_mount (fs/namespace.c:5248) 
[ 19.415106][ C0] shmem_init (mm/shmem.c:4684) 
[ 19.415508][ C0] mnt_init (fs/namespace.c:5232) 
[ 19.415907][ C0] vfs_caches_init (fs/dcache.c:3187) 
[ 19.416333][ C0] start_kernel (init/main.c:1058) 
[ 19.416760][ C0] x86_64_start_reservations (arch/x86/kernel/head64.c:495) 
[ 19.417245][ C0] x86_64_start_kernel (arch/x86/kernel/head64.c:488) 
[ 19.417694][ C0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[   19.418133][    C0] irq event stamp: 868370
[ 19.418530][ C0] hardirqs last enabled at (868370): __local_bh_enable_ip (arch/x86/include/asm/paravirt.h:698 kernel/softirq.c:387) 
[ 19.419370][ C0] hardirqs last disabled at (868369): __local_bh_enable_ip (kernel/softirq.c:364 (discriminator 1)) 
[ 19.420216][ C0] softirqs last enabled at (868292): __do_softirq (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:583) 
[ 19.421025][ C0] softirqs last disabled at (868297): run_ksoftirqd (kernel/softirq.c:411 kernel/softirq.c:925) 
[   19.421823][    C0]
[   19.421823][    C0] other info that might help us debug this:
[   19.422522][    C0]  Possible unsafe locking scenario:
[   19.422522][    C0]
[   19.423184][    C0]        CPU0
[   19.423510][    C0]        ----
[   19.423838][    C0]   lock(mount_lock);
[   19.424225][    C0]   <Interrupt>
[   19.424567][    C0]     lock(mount_lock);
[   19.425115][    C0]
[   19.425115][    C0]  *** DEADLOCK ***
[   19.425115][    C0]
[   19.425858][    C0] 2 locks held by ksoftirqd/0/10:
[ 19.426297][ C0] #0: ffffffff8301d700 (rcu_callback){....}-{0:0}, at: rcu_process_callbacks (include/linux/bottom_half.h:20 kernel/rcu/tiny.c:133) 
[ 19.427122][ C0] #1: ffffffff8301d7c0 (rcu_read_lock){....}-{1:2}, at: mntput_no_expire (include/linux/rcupdate.h:329 include/linux/rcupdate.h:781 fs/namespace.c:1299) 
[   19.427921][    C0]
[   19.427921][    C0] stack backtrace:
[   19.428459][    C0] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W       TN 6.9.0-rc3-00075-g9a4131bb20fb #2
[   19.429328][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   19.430179][    C0] Call Trace:
[   19.430505][    C0]  <TASK>
[ 19.430805][ C0] dump_stack_lvl (arch/x86/include/asm/paravirt.h:687 (discriminator 3) arch/x86/include/asm/irqflags.h:127 (discriminator 3) lib/dump_stack.c:117 (discriminator 3)) 
[ 19.431221][ C0] mark_lock+0x473/0x4c0 
[ 19.431661][ C0] ? __lock_acquire (kernel/locking/lockdep.c:4599 kernel/locking/lockdep.c:5091) 
[ 19.432102][ C0] ? __lock_acquire (include/linux/hash.h:78 kernel/locking/lockdep.c:3759 kernel/locking/lockdep.c:3782 kernel/locking/lockdep.c:3837 kernel/locking/lockdep.c:5137) 
[ 19.432550][ C0] ? __lock_acquire (kernel/locking/lockdep.c:4567 kernel/locking/lockdep.c:5091) 
[ 19.432989][ C0] __lock_acquire (kernel/locking/lockdep.c:4567 kernel/locking/lockdep.c:5091) 
[ 19.433415][ C0] ? __lock_acquire (kernel/locking/lockdep.c:5134 (discriminator 9)) 
[ 19.433856][ C0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
[ 19.434269][ C0] ? mntput_no_expire (include/linux/seqlock.h:469 include/linux/seqlock.h:495 include/linux/seqlock.h:823 fs/namespace.c:114 fs/namespace.c:1314) 
[ 19.434708][ C0] ? mntput_no_expire (include/linux/rcupdate.h:329 include/linux/rcupdate.h:781 fs/namespace.c:1299) 
[ 19.435144][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 19.435555][ C0] ? mntput_no_expire (include/linux/seqlock.h:469 include/linux/seqlock.h:495 include/linux/seqlock.h:823 fs/namespace.c:114 fs/namespace.c:1314) 
[ 19.435994][ C0] mntput_no_expire (include/linux/seqlock.h:469 include/linux/seqlock.h:495 include/linux/seqlock.h:823 fs/namespace.c:114 fs/namespace.c:1314) 
[ 19.436421][ C0] ? rcu_process_callbacks (include/linux/bottom_half.h:20 kernel/rcu/tiny.c:133) 
[ 19.436900][ C0] free_mounts (fs/namespace.c:1571) 
[ 19.437291][ C0] ? __x64_sys_mount_setattr (fs/namespace.c:1574) 
[ 19.437772][ C0] ? __x64_sys_mount_setattr (fs/namespace.c:1574) 
[ 19.438253][ C0] delayed_mount_release (fs/namespace.c:1579) 
[ 19.438699][ C0] rcu_process_callbacks (include/linux/rcupdate.h:339 kernel/rcu/tiny.c:103 kernel/rcu/tiny.c:134) 
[ 19.439151][ C0] __do_softirq (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 19.439556][ C0] ? smpboot_thread_fn (kernel/smpboot.c:112) 
[ 19.439997][ C0] ? sort_range (kernel/smpboot.c:107) 
[ 19.440389][ C0] run_ksoftirqd (kernel/softirq.c:411 kernel/softirq.c:925) 
[ 19.443032][ C0] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3)) 
[ 19.443510][ C0] kthread (kernel/kthread.c:388) 
[ 19.443887][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 19.444367][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 19.444788][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 19.445269][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:253) 
[   19.445696][    C0]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240430/202404302220.f8959d4c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


