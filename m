Return-Path: <linux-fsdevel+bounces-72228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0BCE8BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E803015ABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 05:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5D2EB876;
	Tue, 30 Dec 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njwO18Rm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D91EB5CE;
	Tue, 30 Dec 2025 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767074279; cv=fail; b=ZPUHz0MJj0YMoYijx3ufh3c+KYxtVnxeTCekk/g0bjvnil6+R3zePAeBZQclRlXz6MYqzCehlgeqWheNB75YW+iPF2h65gHz7NyB3oswQvOCkDkckcR/vtKsRENDLgUeZsfd9ADiWU+O8UrzpDLku6pL4X0vNMe+mWl5BwFgFwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767074279; c=relaxed/simple;
	bh=l50Y8F9XiGbAPQo/B23tTpAiynrEXiIStWRj3hGMZ/U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X9wqGjHPYjHEfrY5DaQ8szpA+E0ChFqcAPCR5bCp+iiYx+Aj7bAZwEUnUJk7kLGqXOoncv/CpAVO84GHoZr7UANJz4BwO4LQC1E0oKJzEy39ZeDKeuQGxjqQnVSzkI/aHg/KkwekIEx76ZO7/uw1kX9HBPPE0jPDINxkc0gcZBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njwO18Rm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767074278; x=1798610278;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=l50Y8F9XiGbAPQo/B23tTpAiynrEXiIStWRj3hGMZ/U=;
  b=njwO18RmJUffiiLZ2FSnT8fN3W55jPwONQk31Hi8r15BDR/NBR0w/vkP
   JAxcV8m/jaqmi1UnMlERT+Kw7b+bRdf9oN7nywm97fSHzO4hL+PuzuhNl
   +Q1e55k8AX3ZUOmP+r9eZvnmwoDLbqNPoHB7fAks+QpPbJ4sQpaUlZXxu
   lGXVNIA3Lj/v0dgp2FYIOgIKZP7QCIwECIfrT8/jx4q1MqiD1k2pq7u8O
   NmGOiZCSjBGk9yq+951B4aSx+Xm+TcxANwKDvLYehomVMZVy8tUZzOHJJ
   sDnU/gw3jhalJ6uKfswFgCd/7T5bj8iOguqZhx/7GZceVC4ir3PID1Fle
   Q==;
X-CSE-ConnectionGUID: Rbr5W6WUREOurWST4bGGXg==
X-CSE-MsgGUID: ZAZQeCoUTAWE8SAC5XqRtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="71254007"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="71254007"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 21:57:57 -0800
X-CSE-ConnectionGUID: WlAaT8dSRYO0lM2jupmNGw==
X-CSE-MsgGUID: vZUP3NorSIKKAVhRcTiEHg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 21:57:57 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 21:57:56 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 29 Dec 2025 21:57:56 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 21:57:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnAWC9yyKUrXC5eupIBYc3SEJ64JeKJMjPlIlJuv7kaBGyabpLqnIIPWzn82e1g317+7JJSPKR7pnOI8rQV2ASGlo+9Yqx0fNjMx+Ro3SXtZXx+rObsD9EL102prqcO2njdzdgdROiGilL7Lebq1wAoWs6aSg0mDzPWoJdLnzgtFAIZuv07wJcwijv3d7EmyXXFvhY/lp+6+MGAKuRBSZcTr5Nme1VRnD+mvkD702BLGW61GzqCJATveozPBPV7rgG8MBq8h5QeJfKeEOdDGlvkNuvFqf4QIQN5xdYO4e/h4raRCAuKQlITaRSjnKiXyzszUIhB/rYpgXn09gl7mRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQngPqGVti+sgIDPgyN/+51XbdosOR0Dq/WL1jesy5E=;
 b=CF0oNY4SdM/XSbUTtwO2fO8672ZHeofJQBMNLoSGdTk0PFo9V5pUQLSbCTr5MoF5vkFdMO2Is0o1f7s/rsJ0xvrah7Ho6KBmND0tKi4hzxOhCuKnn9b/S65fGzPpgNYk0TZrsQkW7FEmhYwk6IkKCBZ+gsLbXakCvvqsWTz6FAJFGZKCNLV6Osujos1G1st8FKeO0g0KD7lKcWqtQTC0RaOJdVD9f6QSIXrbyE9B16gsqjXmEfdbWRqEpoGW7Dct7FV4DWkyms+iGhxxATzusnSlt7qcOvJE7MgDt39M4uYbizIORYEWsGtI/G4ReDYbyKynUMzFuKBD3Ce/2d4rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 05:57:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 05:57:54 +0000
Date: Tue, 30 Dec 2025 13:57:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andrei Topala <topala.andrei@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netfs@lists.linux.dev>,
	<ecryptfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Andrei
 Topala" <topala.andrei@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] fs: allow rename across bind mounts on same superblock
Message-ID: <202512301036.b3179a4b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251223173803.1623903-1-topala.andrei@gmail.com>
X-ClientProxiedBy: KUZPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:d10:24::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: e10b639a-d528-4435-32fd-08de47685fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3sKpEP2PNB99YT4OB6FKVPjqxIUBaYA5/2B9HU7VeI7WdwvwBw8/vbskT+9o?=
 =?us-ascii?Q?ajflFS836Mw6kweF6U38Uk2UuionWEjENTZPou7WWLWmNsCUJsAbyOat+DWZ?=
 =?us-ascii?Q?gTtxbysQ6K6ww/JuMX3Y6qWLnCtKg2sDfym4U8JN3TXu28hOMOa49OyWFSyu?=
 =?us-ascii?Q?x3BYPbtXac+8NCK9pUW+7iRSCp8di8goJD/HaSky0aWCeYRE/X1qcn7DOeoU?=
 =?us-ascii?Q?h+RvNmeo6I6U06NlW76lGf2SD2zdJRUqKHvzg7GKthpJNT8B3pqA6qgNlgb0?=
 =?us-ascii?Q?5VmKkat8ReIBaSRcF+jB/PdBa+tY0bPLlYvsO8/JPzkLEaNsfDySI2Nm2cWb?=
 =?us-ascii?Q?PS34IfBmgWnj7loN+zgGSKPMfs00tVP0GaIchnypKYClMt4QBgwOOblk/pJG?=
 =?us-ascii?Q?Wfjcl4eF9747/mtpO4vahjoL9UaBaSHLAYf1oXCJGggTkUQfraHyLY8PP4Mc?=
 =?us-ascii?Q?nSq/WKYaHvQxk+YrTf9I0T6UPLXblIeAecFf7+z4wa30S4I8DYohtR5jv55I?=
 =?us-ascii?Q?cHVAnyc8oa+/f3gNWA6we/wHXosWKEReeSBgz2IbNShhMIF0nvn3j6L0T4zF?=
 =?us-ascii?Q?Pg8a/0WisrXimwuNpIXVf88x2ADbG6h5DdeADV35o9EtGFgdxGzDki1r8cSN?=
 =?us-ascii?Q?L5yqqkvX+QkeuS0j20yBKJ4WLwdphIzVBkYrGrPvBwkFOdXF/HAzABLbMEYp?=
 =?us-ascii?Q?YwZzX8fPqaW0Mt1chS/lN0Q5EPrDGGq4T/BQq0R+zvIZiHSwTAl1CfQdW+3W?=
 =?us-ascii?Q?Hcrnw9VFHa4MTxJWMC6Zhqa6tRCx2GYueGIB4BG4C1njsFqUiYxZfMZbU0E3?=
 =?us-ascii?Q?oNhwWPLwFTmDN9twUv1A3YAAdOIQG8UQd5mWRZCgL5AOYZ6pVx1zJCJDVCRN?=
 =?us-ascii?Q?miAOrMjTJ5jt+YJWCVA9UAwxvnj8ZPCTXJ1YvrWm/hry1D1Wm0ux0k9UXvrh?=
 =?us-ascii?Q?w+0yBU4wbxkPlBbG0CXheC75Se6x34QOfs2Xbt380lgzcU86ywh72QXfhS5j?=
 =?us-ascii?Q?1H9fBzGe9TsV2HyoA9BM8Tkk8IvYG5loPzCZq2G1U+SHyPepNqY54yYM4g+a?=
 =?us-ascii?Q?3FfJi+RppwYpe8e+O6kogZzu24PS58aVIlewtAaz/Dk5qQl9p14cy4xFHSgF?=
 =?us-ascii?Q?wR5BegVyeZC7In7/G3g3DPE7F54R/aU/X/FHYqrmIcXkup6hwYyvYMWnLxWs?=
 =?us-ascii?Q?FOju0GPgGSc5nhN5jASjHCdmr04wYE8Q5TkB6savkzY1E3rjxIIlrSraUzDT?=
 =?us-ascii?Q?e/sbvRwr8+GMudcvdPPUqv5/dCyhlrhZlG5fjkGYbqgtBDRhiQFGP9ygWwCg?=
 =?us-ascii?Q?PtnGT0OGNhWoEcWplB/OoBCYRBbqA3ryWFsTgfTjiGeoOSM6LA82kLoGsqB1?=
 =?us-ascii?Q?m9FbRZNsxfCLuv26epg1Kz5AOu1fzStXB+bRXoeDCN27KBDeRwOEF21NJdV1?=
 =?us-ascii?Q?8sEKYg5nyMBwu4UXvXsHqWGwFZ8KAwoDSjkpSHlzrv+9GjO7FxQR1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0zSi3qrGDO2nVpN8/vgs3xnn4GKU3rjofp7C/tb3xBsVAY3FNl53dE1uwIT?=
 =?us-ascii?Q?F2hDiUOoLU8tyFwnsLSWYq0dufOPNMN9wZNXbEwl3/NNGQzpA358F1UNw2db?=
 =?us-ascii?Q?NiEMIjNT18JghrtJilx5VFukGDGjIqW8o1nQcfO8aFN1MBW1KDPv7FVR9BgI?=
 =?us-ascii?Q?SqfSdzX98mIsVyxfpKcB6JsWHeXBB9PlMEoucroVVy0KGRsBgSOUTxD7u/63?=
 =?us-ascii?Q?lyC4ZRM/bUWcNU2kedYSJxVH5Xt90JzfjHKiYe+zdO3sY+FlVOVcSJd1Z3W+?=
 =?us-ascii?Q?HWPLshujDFulkeHg+vHF+jPS8UZ2t0hxViZm3evbHuymTkEOiLve7qYDG5XL?=
 =?us-ascii?Q?aF1Dc9wXXwxFuFZXZ2qqq34pDj7r9Pz60j+h6yFZDViRw0UcpdmQ9InvsK7H?=
 =?us-ascii?Q?xwoLNrSW+qlSDxI/fgnb66JAZBQEk4erWD04vxnKpv+5bRUTTvqlYmz2/Fsj?=
 =?us-ascii?Q?/CkzH8DUaQRA+Zi65Zr+HBt2ywNwJDvHIU38PK3YmLLVHscNJD7fWKuzHpMx?=
 =?us-ascii?Q?5EJszUeXV9DogGf9ufB35+cWv3hroXrAZIvBpbFZX9PvaNyGkzEtmN7Ji9B0?=
 =?us-ascii?Q?grawXIMTdyIowTtUxY4BH9Hljn8531WES+Kziv0ukPlHRHWhSJcLsUw07oEJ?=
 =?us-ascii?Q?I6auoRnSLwbWJpL6Oxqk9ycSNJV/gL5rLQsvOE0d+WtxC+tL4eLEjfuqsNOg?=
 =?us-ascii?Q?oyrhNDpbiOC/kyKUlhFEo6JwYVv8zgNkUkG4xmFNd96iwYTf4LCyq6b5HXpw?=
 =?us-ascii?Q?lDOQpwZpnPnFvVSx/S1tAfbFawqVGRnsczWWd/hv/VbGb3C89fW4bwRGm1WO?=
 =?us-ascii?Q?cvv6wyNZU6qF6Y4UsjlnlXwB9IgtNo4VCJpjfAmuAO/GB7iDO9SnbL//CqFW?=
 =?us-ascii?Q?JAHLRu1hoaEt9NCA0qFRXptWmFaIs5pStQSo88wXzSGDQKyOH+1RvKcC+dGX?=
 =?us-ascii?Q?LKIBRs1ByahZcp1R0Q0n9yhXHCnlqqyUKF3wqmcqrqqMbYokb2fIdU0dVE26?=
 =?us-ascii?Q?v5VLdOnIX+UuDm/rk06YPvPTzjGVym+P1u+DBhMxalQYgdLYiyOZDE4C6PXo?=
 =?us-ascii?Q?A9TFy9hw1UQMjPZ88qzk/reC/S7n0rotQE/HB9Auc0TnhiSFtlDVE0jBuxOZ?=
 =?us-ascii?Q?4QnIlBNCTfJ3cQwLpnRkaUVn9fW4/yIPI+bqLolEj24iPqh8WvFElxyUMzQV?=
 =?us-ascii?Q?dv3iMW+Jc1x95IqAnt5IFWTpSv5NUXvJmzDXSnAyTxJGRAoJouQgmIg0QFxG?=
 =?us-ascii?Q?M+5iyB9Cs4zkPkdRrHCebaAJLL3/MLvBtOQ7/sbVyQhbpYoq/25y659E1ZQS?=
 =?us-ascii?Q?hhkf8CTDoGBBgMOUIqYJqS/SpEcgroFCfV4pOa3w8kieFvMKnqpuOPY2brzX?=
 =?us-ascii?Q?SGTdHSPVNLqysWdna184jzQLpr1ABMGCLFAG7c8cGjGhndSOL0U9ux5p1Cvb?=
 =?us-ascii?Q?05Jp+ccugY/L4K33Xuxr9y2x+CYT5zhFOzYjKUAezuqJ1/vWIa66h7nUfYkD?=
 =?us-ascii?Q?8g9NpDei/CIQIY2Gfv2Vax1MH4uAAtETKC1ZXTPnAVkAhFf80xHEDpuhzaG3?=
 =?us-ascii?Q?tBja1W94PrfJOhZWpQs4NA/eHI2lm8j/FRW4nB0LOr2GMDjKsNwKAcZ/WTER?=
 =?us-ascii?Q?rl13uVjecihIIUTWALpuLabE+yHBViMfMxnxXuPyPQdVSBzYWlpcGryAv8UF?=
 =?us-ascii?Q?f8C7mEh0SI8pFbPafPFbZittGSz8bFZnxmPMBtZzA6dTAQc+ALuY+ieAUFqC?=
 =?us-ascii?Q?xWVT6SvsPQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e10b639a-d528-4435-32fd-08de47685fee
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 05:57:54.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK8WLn1U83CmQYNNDMU8GMua4tgvBBC+C3hvtZQHVfilGyVmXVekc4LeDtvhJkfBfaA3BgMQm4WkgxKOux4MNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.633.fail" on:

commit: 6c7ce82ab1bf6ff8bf562d830a5e9a2dd26b4ebb ("[PATCH] fs: allow rename across bind mounts on same superblock")
url: https://github.com/intel-lab-lkp/linux/commits/Andrei-Topala/fs-allow-rename-across-bind-mounts-on-same-superblock/20251224-020432
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20251223173803.1623903-1-topala.andrei@gmail.com/
patch subject: [PATCH] fs: allow rename across bind mounts on same superblock

in testcase: xfstests
version: xfstests-x86_64-a668057f-1_20251209
with following parameters:

	disk: 4HDD
	fs: ext2
	test: generic-633



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512301036.b3179a4b-lkp@intel.com

2025-12-28 19:38:18 cd /lkp/benchmarks/xfstests
2025-12-28 19:38:18 export TEST_DIR=/fs/sdb1
2025-12-28 19:38:18 export TEST_DEV=/dev/sdb1
2025-12-28 19:38:18 export FSTYP=ext2
2025-12-28 19:38:18 export SCRATCH_MNT=/fs/scratch
2025-12-28 19:38:18 mkdir /fs/scratch -p
2025-12-28 19:38:18 export SCRATCH_DEV=/dev/sdb4
2025-12-28 19:38:18 echo generic/633
2025-12-28 19:38:18 ./check -E tests/exclude/ext2 generic/633
FSTYP         -- ext2
PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.19.0-rc1-00037-g6c7ce82ab1bf #1 SMP PREEMPT_DYNAMIC Mon Dec 29 01:50:58 CST 2025
MKFS_OPTIONS  -- -F /dev/sdb4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb4 /fs/scratch

generic/633        [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/633.out.bad)
    --- tests/generic/633.out	2025-12-09 15:20:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/633.out.bad	2025-12-28 19:41:48.101143921 +0000
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +vfstest.c: 199: rename_crossing_mounts - Success - failure: renameat
    +vfstest.c: 2418: run_test - Success - failure: cross mount rename
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/633.out /lkp/benchmarks/xfstests/results//generic/633.out.bad'  to see the entire diff)
Ran: generic/633
Failures: generic/633
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251230/202512301036.b3179a4b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


